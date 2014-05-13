# Printing twitter and github followers


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)

this script will get your followers count
across socsial media, i get the user profile
page and use Regex to grab the followers number
```ruby
require 'open-uri'

```
Getting github followers
```ruby
def github( username )
  page = open("https://github.com/#{username}").read
  followers = page.scan(/<.+>([0-9]+)<.+>[[:space:]]+followers/i).flatten.first
  puts "Github : #{followers} Followers"
end

```
get twitter followers by twitter handle
```ruby
def twitter( username )
  page = open("https://twitter.com/#{username}").read
  followers = page.scan(/followers<.+>[[:space:]]+<.+>([0-9]+)<.+>/i).flatten.first
  puts "Twitter : #{followers} Followers"
end

```
use them to print your followers
using github username and
twitter handle
```ruby
github 'blazeeboy'
twitter 'blaz_boy'```