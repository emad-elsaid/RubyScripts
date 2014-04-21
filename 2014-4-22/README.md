# Forgiving ruby


```ruby
#!/usr/bin/env ruby

```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby


```
monkey batch, yup that a bad practice,
but lets say that this is a proof of concept

we'll open the object class and handle the
method missing situation, we'll claculate
distance between the requested method and
all methods available in object, then the nearest
method if distance doesn't exceed certain number
then execute it.
```ruby
class Object
  def method_missing(meth, *args, &block)
    threshold = 3
    all_meth = methods.sort
    all_meth.sort_by! do |m| 
      string_distance m, meth
    end
    if string_distance(all_meth.first, meth) <= 3
      send all_meth.first, *args, &block
    else
      super
    end
  end


```
we'll calculate distance between 2 string by
getting number of characters in 1 and not in 2
and number chars in 2 not in 1, sum the two
differences and return that weight
less weight is more similar method
```ruby
  def string_distance(str1, str2)
    one_way = str1.to_s.chars - str2.to_s.chars 
    the_other_way = str2.to_s.chars - str1.to_s.chars 
    one_way.size + the_other_way.size
  end
end


```
## UseCase ?
you can use `nil` instead of `nil?`
```ruby
p "26512135".nil

```
you can use `toi` and `tof` instead of `to_i` and `to_f`
```ruby
p "12123".tof


```
this way ruby will be more forgiving if you wrote
method name with wrong character or less character or more
with 1 character, when you increate the `threshold` it'll
be more forgiving :D,

happy coding.