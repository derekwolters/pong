class GameObject
    attr_accessor :x
    attr_accessor :y
    attr_accessor :w
    attr_accessor :h
  
    def initialize(x, y, w, h)
      @x = x
      @y = y
      @w = w
      @h = h
    end
  
    def left
      x
    end
  
    def right
      x + w
    end
  
    def right=(r)
      self.x = r - w
    end
  
    def top
      y
    end
  
    def top=(t)
      self.y = t
    end
  
    def bottom
      y + h
    end
  
    def center_y
      y + h/2
    end
  
    def center_x
      x + x/2
    end
  
    def bottom=(b)
      self.y = b - h
    end
  
    def collide?(other)
      x_overlap = [0, [right, other.right].min - [left, other.left].max].max
      y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max
      x_overlap * y_overlap != 0
    end
  end