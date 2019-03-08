require 'gosu'

class Ball #< Gosu::Window

  #def initialize
  #  super WIDTH, HEIGHT

    @ball_image = Gosu::Image.new("assets/ballBlue.png")

    @ball_x = 640 / 2
    @ball_y = 480 / 2

    @step_x = 3
    @step_y = 3
  #end
  
  #def update
    # update ball position and bounce if needed
  #  @ball_x += @step_x
  #  @ball_y += @step_y

  #  @step_y *= -1 if @ball_y > (HEIGHT - @ball_image.height - @wall_image.height) || @ball_y < @wall_image.height
  #  @step_x *= -1 if @ball_x > (WIDTH - @ball_image.width - @wall_image.width) || @ball_x < @wall_image.width
  #end
  
  def draw
    # draw ball
    @ball_image.draw(@ball_x, @ball_y, 1)
  end
end

#Ball.new.show
