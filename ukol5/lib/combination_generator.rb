class CombinationGenerator
  
  def initialize(items)
    @items = items
  end
  
  def generate_combinations(num_of_items)
    if(num_of_items < 1 || num_of_items > @items.length)
      raise "Number of items in combination must be > 1 and <=" + @items.length.to_s
    end
    
    
    ret = Array.new()
    tmp = Array.new(num_of_items)
    
    combinate(@items, num_of_items, 0, 0, tmp, ret)
    
    return ret
  end
  
  def combinate(items, group_size, current_index, offset, tmp, ret)
    if(current_index > (group_size - 1))
      ret.push(Array.new(tmp))
      return
    end
    
    off = offset
    (current_index + offset).upto(items.length - (group_size - current_index)) {|i|
      tmp[current_index] = items[i]
      combinate(items, group_size, current_index + 1, off,  tmp, ret)
      off += 1
    }
  end
  
end