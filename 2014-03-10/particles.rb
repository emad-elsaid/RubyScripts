require 'gosu'
$width, $height = 200, 200
$number_of_particles = 200

class Quad
  def initialize
    @pos = {x:rand($width), y:rand($width)}
    @vel = { x:(rand(5)+1)*[1,-1].sample, y:(rand(5)+1)*[1,-1].sample }
    @size = rand(4)*[1,-1].sample
    @color = [  Gosu::Color::GRAY, Gosu::Color::WHITE,
                Gosu::Color::AQUA, Gosu::Color::RED,
                Gosu::Color::GREEN, Gosu::Color::BLUE,
                Gosu::Color::YELLOW, Gosu::Color::FUCHSIA,
                Gosu::Color::CYAN ].sample
  end
  def update
    @vel[:x] = @vel[:x] * -1 if @pos[:x] <= 0 or @pos[:x] >= $width
    @vel[:y] = @vel[:y] * -1 if @pos[:y] <= 0 or @pos[:y] >= $height
    @pos[:x] += @vel[:x]
    @pos[:y] += @vel[:y] 
  end
  def draw win
    win.draw_quad @pos[:x]-@size, @pos[:y]-@size, @color,
                  @pos[:x]+@size, @pos[:y]-@size, @color,
                  @pos[:x]+@size, @pos[:y]+@size, @color,
                  @pos[:x]-@size, @pos[:y]+@size, @color
  end
end

class GameWindow < Gosu::Window
  def initialize
    super $width, $height, false
    self.caption = "Quads"
    @quads = []
    $number_of_particles.times { @quads << Quad.new }
  end
  def update
    @quads.each {|q| q.update }
  end
  def draw
    color = Gosu::Color::WHITE
    draw_quad 0, 0, color, $width, 0, color, $width, $height, color, 0, $height, color
  	@quads.each { |q| q.draw self }
  end
end

window = GameWindow.new
window.show