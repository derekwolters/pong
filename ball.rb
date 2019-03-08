require 'gosu'

class Ball < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Ball bounce"

    @ball_image = Gosu::Image.new("assets/BallBlue.png")
    @wall_image = Gosu::Image.new("assets/element_green_square.png")

    @ball_x = WIDTH / 2
    @ball_y = HEIGHT / 2

    @step_x = 3
    @step_y = 3
  end
  
  def update
    # update ball position and bounce if needed
    @ball_x += @step_x
    @ball_y += @step_y

    @step_y *= -1 if @ball_y > (HEIGHT - @ball_image.height - @wall_image.height) || @ball_y < @wall_image.height
    @step_x *= -1 if @ball_x > (WIDTH - @ball_image.width - @wall_image.width) || @ball_x < @wall_image.width
  end
  
  def draw
    # draw walls and ball
    x = 0
    while (x < WIDTH) do
      @wall_image.draw(x, 0, 2)
      @wall_image.draw(x, HEIGHT - @wall_image.height, 2)
      x += @wall_image.width
    end    

    y = @wall_image.height

    while (y < height) do
      @wall_image.draw(0,y, 2)
      @wall_image.draw(WIDTH - @wall_image.width, y, 2)
      y += @wall_image.height
    end  

   

    @ball_image.draw(@ball_x, @ball_y, 1)
  end
end

Ball.new.show