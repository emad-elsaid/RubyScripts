#!/usr/bin/env ruby
require 'mail' # gem install mail --no-document

# Credit to : 
# http://stackoverflow.com/questions/12884711/how-to-send-email-via-smtp-with-rubys-mail-gem

def ask question
  print "#{question} ? : "
  $stdin.gets.chomp!
end

# get it from : 
# https://www.tumblr.com/settings/blog/yourBlogName
# in the Post by Email section
tumblr_email = 'xxxxxxx@tumblr.com'

email = ask('what is your gmail address')

$options = { 
	:address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => email,
  :user_name            => email,
  :password             => ask('what is your password'),
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}

Mail.defaults do
  delivery_method :smtp, $options
end


Mail.deliver do
  from     $options[:user_name]
  to       tumblr_email
  body     ask('write any message associated with the image')
  ARGV.each do |file|
    add_file file
  end
end

puts 'Posting to tumblr succeeded :)'
