#!/usr/bin/env ruby
require 'gosu' # gem install gosu
$dimension, $squares = 200, 20
$size = $dimension / $squares
class Entity
  def initialize(x,y, win)
    @pos = {x:$dimension/$squares*x, y:$dimension/$squares*y}
    @last_update = @update_limit = 4
    @color = {h:360/$squares.to_f*x, s:1/$squares.to_f*y}
    @color_dir = {h:360/$squares.to_f,s:1/$squares.to_f}
    @shift = {x:x,y:y}
  end
  def update
  	@last_update -= 1
  	if @last_update==0
  		@color_dir[:h] *= -1 if @color[:h]>=360 or @color[:h]<=0
  		@color_dir[:s] *= -1 if @color[:s]>=1 or @color[:s]<=0
  		@color[:h] += @color_dir[:h]
  		@color[:s] += @color_dir[:s]
  		@color[:h] = 0 if @color[:h]<0
  		@color[:s] = 0 if @color[:s]<0
	    @last_update = @update_limit
	end
  end
  def draw win
  	color = Gosu::Color.from_hsv @color[:h], @color[:s], 0.7
    win.draw_quad @pos[:x]-$size, @pos[:y]-$size, color,
                  @pos[:x]+$size, @pos[:y]-$size, color,
                  @pos[:x]+$size, @pos[:y]+$size, color,
                  @pos[:x]-$size, @pos[:y]+$size, color
  end
end
class GameWindow < Gosu::Window
  def initialize
    super $dimension, $dimension, false
    self.caption = "Color Dream"
    @quads = []
    $squares.times do |i|
    	$squares.times do |j|
    		@quads << Entity.new( i, j, self) 
    	end
    end
  end
  def update() @quads.each {|q| q.update } end
  def draw() @quads.each { |q| q.draw self } end
end
GameWindow.new.show