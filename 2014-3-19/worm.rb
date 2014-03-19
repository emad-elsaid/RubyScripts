#!/usr/bin/env ruby
require 'gosu' # gem install gosu --no-document
include Gosu

$dimension, $splits = 200, 20
$size = $dimension.to_f / $splits.to_f

class Worm
  attr_writer :dir
  def initialize() reset end
  def reset
    @parts = [[0,0],[1,0],[2,0]]
    @dir, @dir_matrix = KbRight, { KbUp=>[0,-1], KbDown=>[0,1],KbRight=>[1,0], KbLeft=>[-1,0] }
    generate_food
  end
  def generate_food() @food = [rand($splits),rand($splits)] end
  def update
    part = [@parts[-1][0]+@dir_matrix[@dir][0], @parts[-1][1]+@dir_matrix[@dir][1]]
	@food!=part ? @parts.shift : generate_food
	if part[0]*part[1]<0 or part[0]>$splits or part[1]>$splits or @parts.include?(part)
		reset
	else
		@parts.push part
	end
  end
  def draw_split win, split
	win.draw_quad split[0]*$size, split[1]*$size, Color::GREEN,
                  split[0]*$size+$size, split[1]*$size, Color::GREEN,
                  split[0]*$size+$size, split[1]*$size+$size, Color::GREEN,
                  split[0]*$size, split[1]*$size+$size, Color::GREEN
  end 
  def draw win
  	draw_split win, @food
  	@parts.each { |split| draw_split win, split }
  end
end

class GameWindow < Window
  def initialize
    super $dimension, $dimension, false, 100
    self.caption = "Worm Game"
    @worm = Worm.new
  end
  def button_down(key) @worm.dir = key if [KbDown,KbUp,KbRight,KbLeft].include? key end
  def update() @worm.update end
  def draw() @worm.draw self end
end
GameWindow.new.show