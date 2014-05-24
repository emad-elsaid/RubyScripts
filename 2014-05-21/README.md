# Share your music library on the network


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby

require 'sinatra' # gem install sinatra

```
specify port and environment as production
to allow external access to server
```ruby
set :port, 3000
set :environment, :production
```
your media library path
```ruby
MEDIA_PATH = '/Volumes/Data/Songs'

```
get all mp3 files in my media library and sort
then by file name
```ruby
mp3s = Dir.glob("#{MEDIA_PATH}/**/*.mp3")
data = mp3s.map do |mp3|
  {
    path: mp3,
    filename: File.basename(mp3, '.mp3')
  }
end

```
render the index page as set if files names
and a player beside it, player will sent file index in data variable
and another path will read file to stream it
```ruby
get '/' do
  media_partial = data.map.with_index do |d, i| 
    '<audio src="/play/'+i.to_s+'" controls preload="none"></audio> '+
    '<a href="/play/'+i.to_s+'">'+d[:filename]+'</a>'
  end.join '</br>'
<<-EOT
<!DOCTYPE html>
<html>
  <head>
    <style>
      body{
        font: 14px Tahoma;
        line-height: 150%;
      }
    </style>
    <title>Shared Media Center</title>
  </head>
  <body>
```
{media_partial}
```ruby
    <hr>
```
{data.size} Media files found.
```ruby
  </body>
</html>
EOT
end

```
this path will catch any url starts with "play"
and will stream media to user, so when
user hit the play button it'll start playing
the mp3 file
```ruby
get '/play/:id' do
  send_file data[params[:id].to_i][:path]
end```