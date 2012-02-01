
class Rectangle
  
  attr_reader :x
  attr_reader :y
  attr_reader :width
  attr_reader :height
  
  def initialize(x, y, width, height = width)
      
      if !x.is_a?(Numeric)
        raise 'X argument must be numeric'
      end
      
      if !y.is_a?(Numeric)
        raise 'Y argument must be numeric'
      end
      
      if !width.is_a?(Numeric)
        raise 'Width argument must be numeric'
      end
      
      if !height.is_a?(Numeric)
        raise 'Height argument must be numeric'
      end
      
      if width < 0
        raise 'Width must be positive integer'
      end
      
      if height < 0
        raise 'Height must be positive integer'
      end
     
      @x = Float(x)
      @y = Float(y)
      @width = Float(width)
      @height = Float(height)
  end
  
  def area
    return @width * @height
  end
  
  def common_rectangle(other)
    if(!other.is_a?(Rectangle))
      raise 'Argument must be a rectangle'
    end
    
    if((@x - other.x).abs >= (@width + other.width) || (@y - other.y).abs >= (@width + other.width)) 
      return nil #does not intersect
    end
    
    new_x = intersection_center(@x, other.x, @width, other.width)
    new_width = intersection_width(@x, other.x, @width, other.width)
    new_y = intersection_center(@y, other.y, @height, other.height)
    new_height = intersection_width(@y, other.y, @height, other.height)

    return Rectangle.new(new_x, new_y, new_width, new_height)
  end
  
  def intersection_width(x1, x2, w1, w2)
    center_dist = (x1 - x2).abs
    
    #no intersection
    if(center_dist >= (w1 + w2))
      return nil
    end
      
    if((center_dist + w1) <= w2/2)
      #first rectangle is inside second
      return w1
    end
    
    if((center_dist + w2) <= w1/2)
     #second rectangle is inside first
     return w2
    end
    
    return (center_dist - ((w1 + w2)/2)).abs
  end
  
  def intersection_center(x1, x2, w1, w2)
    center_dist = (x1 - x2).abs
    
    #no intersection
    if(center_dist >= (w1 + w2))
      return nil
    end
    
    if((center_dist + w1) <= w2/2)
      #first rectangle is inside second
      return x1
    end
    
    if((center_dist + w2) <= w1/2)
     #second rectangle is inside first
     return x2
    end
    
    #make x1 < x2
    if(x1 > x2)
      tmp = x2
      x2 = x1
      x1 = tmp
      
      tmp = w2
      w2 = w1
      w1 = tmp
    end
    
    int_width = intersection_width(x1, x2, w1, w2)
    
    return x2 - (int_width / 2) - (w2/2 - int_width)
    
  end
  
  def to_s
    return "Rectangle(x=" + @x.to_s + ",y=" + @y.to_s + ",width=" + @width.to_s + ",height=" + @height.to_s + ")"
  end
  
end

