# A Method swapping between objects in ruby (method swizzle)


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)
```ruby
def swap_methods(from_obj, from_method, to_obj, to_method)
  
  from_alias  = "#{from_method}_#{rand 1000}"
  to_alias    = "#{to_method}_#{rand 1000}"

```
alias methods in both objects
```ruby
  from_obj.class.class_eval do
    alias_method from_alias, from_method
  end

  to_obj.class.class_eval do
    alias_method to_alias, to_method
  end

```
override methods and call aliases in both direction
```ruby
  from_obj.define_singleton_method(from_method) do |*params, &block|
    to_obj.send(to_alias, *params, &block)
  end

  to_obj.define_singleton_method(to_method) do |*params, &block|
    from_obj.send(from_alias, *params, &block)
  end

end

```
calling swap between two methods on two objects
should swap them, so if you call obj1.method1
will execute obj2.method2 and vice versa
```ruby
obj1 = "this is my first string object"
obj2 = "this is my second string object"
swap_methods obj1, :to_s, obj2, :to_s

```
this should print the second string
```ruby
puts obj1.to_s
```
 and this should print the first one
```ruby
puts obj2.to_s

```
swapping String new method with
other class new method, so whenever
you create a new String an instance of
the other class
```ruby
class X
  attr_accessor :value
  def initialize(value)
    @value = value
  end
end
swap_methods String, :new, X, :new
x_instance = String.new "Heeeey"
puts x_instance.class

```
this code will output the following lines:

this is my second string object

this is my first string object

X


it normally should be :

this is my frist string object

this is my second string object

String