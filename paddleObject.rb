require 'gosu'
require './gameObject'

class Paddle < GameObject
    WIDTH = 12
    HEIGHT = 60
  
    def initialize(x, y, colorR, colorG, colorB)
      super(x, y, WIDTH, HEIGHT)
      @colorR = colorR 
      @colorG = colorG
      @colorB = colorB
    end
  
    def draw
      Gosu.draw_rect x, y, w, h, Gosu::Color.rgb(@colorR, @colorG, @colorB)
    end
  end