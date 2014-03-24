#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'sinatra'

set :port, 3000
set :environment, :production

get '/' do
	<<-EOT
<html><head>
	</head><body style="padding:0px;margin:0px;">
	<form action="/upload" method="post" enctype="multipart/form-data" >
		Choose files <input type="file" name="files[]" multiple>
		<input type="submit" value="Upload" />
	</form>
</body></html>
EOT
end

post '/upload' do
	params['files'].each do |f|
		tempfile = f[:tempfile]
		filename = f[:filename]
		FileUtils.copy(tempfile.path, "./#{filename}")
	end
	redirect '/'
end