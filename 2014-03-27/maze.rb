#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'gosu'
include Gosu
DIMENSION, SPLITS, COLOR = 200, 50, Color::GREEN
# credits to: http://en.wikipedia.org/wiki/Maze_generation_algorithm
class GameWindow < Window
  def initialize
    super DIMENSION, DIMENSION, false, 1000
    self.caption = "Maze"
  end
  def draw
    complexity, density = 0.75, 0.75
    shape = [(SPLITS / 2) * 2 , (SPLITS / 2) * 2 ] # Only odd shapes
    # Adjust complexity and density relative to maze size
    complexity = (complexity * (5 * (shape[0] + shape[1])))
    density    = (density * (shape[0] / 2 * shape[1] / 2))
    z = Array.new(shape[0]){ Array.new(shape[1], 0) } # Build actual maze
    # Fill borders
    z[0] = z[-1].fill 1
    z.each { |l| l[0] = l[-1] = 1 }
    for i in 0...density # Make isles
        x, y = rand(shape[1] / 2) * 2, rand(shape[0] / 2) * 2
        z[y][x] = 1
        for j in 0...complexity
            neighbours = []
            neighbours << [y, x - 2] if x > 1
            neighbours << [y, x + 2] if x < shape[1] - 2
            neighbours << [y - 2, x] if y > 1
            neighbours << [y + 2, x] if y < shape[0] - 2
            unless neighbours.empty?
                y_,x_ = neighbours[rand(neighbours.size - 1)]
                if z[y_][x_] == 0
                    z[y_ + (y - y_) / 2][x_ + (x - x_) / 2] = z[y_][x_] = 1
                    x, y = x_, y_
                end
            end
        end
    end
    size = DIMENSION/SPLITS
  	z.each_with_index do |row, x|
        row.each_with_index do |value, y|
            draw_quad x*size, y*size, COLOR,
                      x*size+size, y*size, COLOR,
                      x*size+size, y*size+size, COLOR,
                      x*size, y*size+size, COLOR if value==1
        end
    end
  end
end
GameWindow.new.show