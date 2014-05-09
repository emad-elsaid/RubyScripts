# Download latest images from AWW subreddit


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby
require 'open-uri' # we'll need to download image with that
require 'ruby_reddit_api' # gem install ruby_reddit_api

```
method will take imgur url and
filename to save image to it
```ruby
def download_imgur( url, filename )
  image = open( "#{url}.jpg" ).read
  File.write("#{filename}.jpg", image)
end

```
make me a reddit client please
```ruby
r = Reddit::Api.new

```
browse AWW subreddit
and download images if their url
is referencing an imgur link
```ruby
posts = r.browse("aww")
posts.each.with_index(1) do |r, i|
  puts "Downloading #{i}/#{posts.size}"
  download_imgur r.url, r.id if r.url.include? 'imgur'
end
```