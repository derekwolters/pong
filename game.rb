require 'gosu'
require './ballObject'
require './paddleObject'

class GameWindow < Gosu::Window

  attr_reader :score
  attr_reader :blip_sound
  attr_reader :plucky_sound

  def initialize
    super 640, 480
    self.caption = "Baby Gender Pong ***First to 10 you'll know then!***"

    margin = 20

    @player = Paddle.new( margin, margin, 194, 244, 244 )
    @last_mouse_y = margin

    @enemy = Paddle.new( self.width - Paddle::WIDTH - margin, margin, 244, 194, 194)    

    #@ball = Ball.new( 100, 100, { :x => 4, :y => 4 } )
    @ball = Ball.new()

    @score = [0, 0]
    @font = Gosu::Font.new(50)
    @flash = {}
    @counter = 0
    load_sounds
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    end
  end

  def update
    auto_player
    ai_move

    @ball.update

    if @ball.collide?(@player)
      # play sound
      @ball.reflect_horizontal
      @blip_sound.play
      increase_speed
    elsif @ball.collide?(@enemy)
      # play sound
      @ball.reflect_horizontal
      @blip_sound.play
      increase_speed
    elsif @ball.x <= 0
      @ball.x = @player.right
      score[1] += 1
      @ball.v[:x] = 4
      flash_side(:left)
      @plucky_sound.play
      
    elsif @ball.right >= self.width
      @ball.x = @enemy.left
      score[0] += 1
      @ball.v[:x] = -4
      flash_side(:right)
      @plucky_sound.play
      
    end

    @ball.reflect_vertical if @ball.y < 0 || @ball.bottom > self.height
  end

  def increase_speed
    @ball.v[:x] = @ball.v[:x] * 1.1
  end
 
  def player_move
    y = mouse_y
    diff = y - @last_mouse_y
    @player.y += diff

    @player.y = 0 if @player.y <= 0
    @player.bottom = self.height if @player.bottom >= self.height

    @last_mouse_y = y
  end

  def auto_player
    pct_move = 0
    distance = @player.center_x - @ball.center_x
    if distance > self.width / 3
      pct_move = rand(0.009..0.05)
    elsif distance > self.width / 2
      pct_move = rand(0.01..0.1) 
    else
      pct_move = rand(0.04..0.14) 
    end

    diff = @ball.center_y - @player.center_y
    @player.y += diff * pct_move

    @player.top = 0 if @player.top <= 0
    @player.bottom = self.height if @player.bottom >= self.height
  end

  def ai_move
    pct_move = 0
    distance = @enemy.center_x - @ball.center_x
    if distance > self.width / 3
      pct_move = rand(0.008..0.05) #0.05
    elsif distance > self.width / 2
      pct_move = rand(0.01..0.1) #0.1
    else
      pct_move = rand(0.02..0.14) #0.14
    end    

    diff = @ball.center_y - @enemy.center_y
    @enemy.y += diff * pct_move

    @enemy.top = 0 if @enemy.top <= 0
    @enemy.bottom = self.height if @enemy.bottom >= self.height
  end

  def flash_side(side)
    @flash[side] = true
  end

  def draw
    draw_background

    if @flash[:left]
      Gosu.draw_rect 0, 0, self.width / 2, self.height, Gosu::Color.rgb(244,194,194)
      @flash[:left] = nil
    end

    if @flash[:right]
      Gosu.draw_rect self.width / 2, 0, self.width, self.height, Gosu::Color.rgb(194,244,244)
      @flash[:right] = nil
    end

    draw_center_line
    draw_score
    @player.draw
    @enemy.draw
    @ball.draw
  end

  def draw_background
    Gosu.draw_rect 0, 0, self.width, self.height, Gosu::Color.rgb(169,169,169)
  end

  def draw_center_line
    center_x = self.width / 2
    segment_length = 10
    gap = 5
    color = Gosu::Color.rgb(92,65,65)
    y = 0
    begin
      draw_line center_x, y, color,
                center_x + 5, y + segment_length, color
      y += segment_length + gap
    end while y < self.height
  end

  def draw_score
    center_x = self.width / 2
    offset = 15
    char_width = 25
    z_order = 100    
    colorB = Gosu::Color.rgb(194,244,244)
    colorG = Gosu::Color.rgb(244,194,194)
    @font.draw_text(score[0].to_s, center_x - offset - char_width, offset, z_order, 1 , 1, colorB)
    @font.draw_text(score[1].to_s, center_x + offset, offset, z_order, 1 , 1, colorG)
  end

  def load_sounds
    path = File.expand_path(File.dirname(__FILE__))
    @blip_sound = Gosu::Sample.new(File.join(path, "assets/blip.wav"))
    @plucky_sound = Gosu::Sample.new(File.join(path, "assets/plucky.wav"))
  end
end

window = GameWindow.new
window.show