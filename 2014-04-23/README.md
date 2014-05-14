# How do i automate creating these posts images


```ruby
#!/usr/bin/env ruby

```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby
require 'cairo' # gem install cairo

IMAGE_PATH = '/path/to/image/file.png'


```
open image as Cairo surface
```ruby
image = Cairo::ImageSurface.from_png(IMAGE_PATH)

```
this is out target surface we will paint on it
and save it at the end, we created it a perfect Square
```ruby
target = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, image.width, image_width)

```
context is what enable us to paint
a wrapper of any surface and used to
define what we'll paint and where (the source and mask)
```ruby
cr = Cairo::Context.new(target)


```
to crop `image` we'll
put it as source, then
draw a mask on the target
then fill the space with this image
```ruby
cr.set_source image
cr.rectangle 0, 0, image.width, image_width
cr.fill


```
draw a white semi-transparent
rectangle on it that we will
write the post title on it.
```ruby
cr.set_source_rgba 1, 1, 1, 0.8 # white with 80% alpha
cr.rectangle 0, image_width - 80, image.width, 80
cr.fill


```
write title using Futura font in 30 pixels
```ruby
cr.set_source_rgb 207.0/255, 35.0/255, 64.0/255
cr.select_font_face "Futura", 
                    Cairo::FONT_SLANT_NORMAL, 
                    Cairo::FONT_WEIGHT_BOLD
cr.move_to 25, image_width - 40
cr.set_font_size 30
cr.show_text title
cr.fill


```
write a small text under the title to tell
user that we cropped the original image
```ruby
cr.set_source_rgb 131.0/255, 17.0/255, 45.0/255
cr.select_font_face "Verdana", 
                    Cairo::FONT_SLANT_NORMAL, 
                    Cairo::FONT_SLANT_NORMAL
cr.move_to 25, image_width - 15
cr.set_font_size 14
cr.show_text "As this script is too long, check the rest of it from the link in description"
cr.fill


```
then save the target surface to disk :)
```ruby
cr.target.write_to_png IMAGE_PATH
```