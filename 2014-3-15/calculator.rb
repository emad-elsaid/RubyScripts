#!/usr/bin/env ruby
require 'sinatra' # gem install sinatra --no-ri --no-rdoc
include Math

set :port, 3000
html = <<-EOT
<html><head><style>
#expression,#text{ width:100%; font-size:30px; display:block; margin-bottom:5px; }
span{ background:rgb(230,191,161); display:inline-block; border-radius:3px;}
</style></head><body>

	<input id="expression" placeholder="1+2"/>
	<div id="result"></div>

	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script>
	$('#expression').keyup(function(){
			$.get('/calc',{
				exp:$('#expression').val()
			},function(r){
				$('#result').html(r);
			});
	});
	</script>

</body></html>
EOT

get('/'){ html }
get '/calc' do 
	begin
		eval(params['exp']).to_s
	rescue
		'Your expression is invalid'
	end
end
