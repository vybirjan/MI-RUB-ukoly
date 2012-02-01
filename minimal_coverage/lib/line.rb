class Line
  
  attr_reader :left
  attr_reader :right
  
  def initialize(left_start, right_start)
    if(left_start >= right_start)
      raise "Left must be less than right"
    end
    
    @left = left_start
    @right = right_start
  end
  
  def covered_by?(lines)
    if(lines.is_a?(Array))
      args = lines
    else
      args = [lines]
    end
    
    left.upto(right) {|point|
      covered = false
      args.each {|line|
        if(line.covers(point))
          covered = true
          break
        end
      }
      
      if(!covered)
        return false
      end
    }
    
    return true
  end
  
  def covers(point)
    return point >= left && point <= right
  end
  
  def to_s
    return "Line[" + @left.to_s + "," + @right.to_s + "]"
  end
  
  
end