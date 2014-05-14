#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
# 
# autochanging wallpaper from reddit images
# you have to point the script to your existing
# file you set it as a wallpaper and it will override
# it with a new image every 5 minutes.
# 
# this script works on centos 6 with GNOME/GTK2 interface
require 'open-uri' # we'll need to download image with that
require 'ruby_reddit_api' # gem install ruby_reddit_api

# class will be initialized with
# a subreddit to monitor and a 
# destination file to write the
# downloaded image to it
class RedditWallpaper

  def initialize( subreddit, destination_file = 'bg.jpg' )
    @subreddit = subreddit
    @path = destination_file
    @downloaded = []
    @not_downloaded = []
  end

  # download the url to destination
  def download( url )
    image = open( "#{url}.jpg" ).read
    File.write  @path, image
  end

  # update wallpaper and update images cache
  def update
    # make me a reddit client please
    r = Reddit::Api.new

    # update earth
    posts = r.browse @subreddit
    posts.each do |r|
      @not_downloaded << r.url if r.url.include?('imgur') and !@downloaded.include?(r.url)
    end

    image = @not_downloaded.shift
    download image

  end

end

# i'll get images from earthporn
# they have lots of great images of
# nature places
# and then i'll update it every 5 minutes
downloader = RedditWallpaper.new 'earthPorn', '/home/eelsaid/Pictures/bg.jpg'
loop do
  downloader.update
  sleep 5*60 # wait for 5 minutes
end

