#!/usr/bin/env ruby
# gem install sinatra --no-document
# gem install github-markdown --no-document
require 'sinatra'
require 'github/markdown' 
set :port, 3000

get '/' do
<<-EOT
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>Markdown tester</title>
	</head>
	<body>
		<textarea id="markdown" style="width:100%;height:300px;"></textarea>
		<div id="preview" ></div>
		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
		$('#markdown').keyup(function(){
			$.post('/preview', {md:$('#markdown').val()}, function(response){
				$('#preview').html(response);
			});
		});
		</script>
	</body>
	</html>
EOT
end

post '/preview' do
	GitHub::Markdown.render_gfm params['md']
end
