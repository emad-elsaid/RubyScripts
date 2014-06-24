# Download a list of email gravatar images


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby
require 'open-uri'
require 'digest'

EMAIL_LIST = 'http://pastebin.com/raw.php?i=KdDrmNsX'
SAVE_TO = '/home/eelsaid/Desktop/gravatar/'

```
read emails from source
```ruby
emails = open(EMAIL_LIST).read.lines

```
iterate over all emails, get the gravatar image
and save it locally with the email as file name
but i convert the @ character to a dot .
```ruby
emails.each do | email |
  gravatar_id = Digest::MD5::hexdigest(email.strip.downcase)
  gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
  image_data = open(gravatar_url).read
  file_name = email.strip.downcase.gsub '@', '.'
  File.write "#{SAVE_TO}#{file_name}", image_data
end```