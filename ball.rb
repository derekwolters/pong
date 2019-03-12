require 'gosu'
require './gameObject'

class Ball < GameObject
  WIDTH = 22
  HEIGHT = 22

  attr_reader :v
  def initialize(x, y, v)
    super(x, y, WIDTH, HEIGHT)
    @v = v
    @ball_image = Gosu::Image.new("assets/BallPastel.png")
  end

  def update
    self.x += v[:x]
    self.y += v[:y]
  end

  def reflect_horizontal
    v[:x] = -v[:x]
  end

  def reflect_vertical
    v[:y] = -v[:y]
  end

  #draw ball
  def draw
    @ball_image.draw(x, y, 1)
  end
end

#ball = Ball.new( 100, 100, { :x => 4, :y => 4 } )