require 'koala' # gem install koala --no-document

# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# select "read_mailbox" when authenticating
oauth_access_token = 'xxxxxxxxxxxxxxxxxxxxxx'
graph = Koala::Facebook::API.new(oauth_access_token)

# get all latest messages
limit = 10
threads = {}
page = graph.get_connections('me','inbox')
begin
	page.each do |thread| 
		threads[thread["id"]] = thread["to"]["data"].map {|x| x['name']}.join ' - '
	end
end while page = page.next_page and threads.length<limit

# ask user which one to download
threads.each { |id, to| puts "id: #{id} : between : #{to}" }
print 'What is the ID of the thread you want to download ? : '
id = gets.chomp

messages = [] # hold messages here
page = graph.get_connections id,'comments'
begin 
	begin
		page.reverse.each do |comment|
			messages.unshift "#{comment['from']['name']} [#{comment['created_time']}]: #{comment['message']}"
		end
	end while page = page.next_page

	oldest_msg = graph.get_object(id) # get the first message between you two
	messages.unshift "#{oldest_msg['from']['name']} : #{oldest_msg['message']}"

rescue Exception => e
	puts "Error : #{e}, and proceeded to write results to far."
end

File.write '/Users/blaze/Desktop/log.txt', messages.join("\n") 