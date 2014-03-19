#!/usr/bin/env ruby
require 'gosu' # gem install gosu

$width, $height = 200, 200
$number_of_v_lines,$number_of_h_lines = 10, 10
$chars = ('a'..'z').to_a

class Entity
  def initialize(x,y,vel, win)
    @pos, @vel = {x:x, y:y}, vel
    @font = Gosu::Font.new(win, Gosu::default_font_name, rand(20)+10)
    @char = rand($chars.length)
    @update_limit = rand(50)+10
    @last_update = @update_limit
  end
  def update
  	@last_update -= 1
  	if @last_update==0
	  	@char = (@char==$chars.length-1)? 0 : @char+1
	    @last_update = @update_limit
	end
    @pos[:y] = @pos[:y] >= $height+10 ? -10 : @pos[:y] + @vel 
  end
  def draw
    @font.draw($chars[@char], @pos[:x], @pos[:y], 0, 1.0, 1.0, Gosu::Color::GREEN)
  end
end
class GameWindow < Gosu::Window
  def initialize
    super $width, $height, false
    self.caption = "Matrix"
    @quads = []
    $number_of_v_lines.times do |i|
    	vel = rand(3)+1
    	$number_of_h_lines.times do |j|
    		@quads << Entity.new( $width/$number_of_v_lines*i, $height/$number_of_h_lines*j, vel, self) 
    	end
    end
  end
  def update() @quads.each {|q| q.update } end
  def draw() @quads.each { |q| q.draw } end
end
GameWindow.new.show