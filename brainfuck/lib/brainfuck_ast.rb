class BrainfuckContext
  def initialize()
    @pointer = 0
    @memory = Array.new(30000, 0)
  end
  
  def inc_pointer
    if(@pointer == 30000)
      raise RangeError, "Pointer must not exceed 30000"
    else
      @pointer = @pointer + 1
    end
  end
  
  def dec_pointer
    if(@pointer == 0)
      raise RangeError, "Pointer must not be less than zero"
    else
      @pointer = @pointer - 1
    end
  end
  
  def inc_value
    @memory[@pointer] = (@memory[@pointer] + 1) % 256
  end
  
  def dec_value
    if(@memory[@pointer] == 0)
      @memory[@pointer] = 255
    else
      @memory[@pointer] = @memory[@pointer] - 1
    end
  end
  
  def get_value
    return @memory[@pointer]
  end
  
  def set_value(value)
    if(value < 0 or value > 255)
      raise ArgumentError, "Value must be between 0 and 255"
    else
      @memory[@pointer] = value
    end
  end
  
  def reset
    @pointer = 0
    0.upto(30000) {|i|
      @memory[i] = 0
    }
    
  end
  
  def print_memory(index = @pointer)
    if(index < 0)
      index = 0
    end
    
    if(index > 30000)
      index = 30000
    end
    
    real_index = [0, index - 4].max
    if(real_index + 9 > 30000)
      real_index = 30000 - 10
    end
    
    top = ""
    middle = ""
    bottom = ""
    if(real_index == 0)
      top = "|"
      middle = "|"
      bottom = " "
    else
      top << "..."
      middle << "..."
      bottom << "   "
    end
    
    real_index.upto(real_index + 9) {|i|
      print_memory_internal(i, top, middle, bottom)
    }
    
    top << "|"
    middle << "|"
    
    if(real_index == 30000 - 10)
      top << "|"
      middle << "|"
    else
      top << "..."
      middle << "..."
    end
    
    puts top
    puts middle
    puts bottom
  end
  
  private
  
  def print_memory_internal(index, top, middle, bottom)
    top << "| "
    middle << "| "
    bottom << "  "
    
    value = byte_to_s(@memory[index])
    size = [value.length, index.to_s.length].max
    ptr = ""
    if(index == @pointer)
      ptr = "^"
    end
    
    top << pad_to_width(index.to_s, size)
    middle << pad_to_width(value, size)
    bottom << pad_to_width(ptr, size)
    
    top << " "
    middle << " "
    bottom << " "
  end
  
  def byte_to_s(value)
    if(value > 31 and value < 127)
      return "'" << value.chr << "'"
    else
      val = value.to_s(16)
      ret = "0x"
      if(val.length < 2)
        ret << "0"
      end
      ret << val
      return ret
    end
  end
  
  def pad_to_width(text, width)
    remaining = width - text.length
    remaining = [0, remaining].max
    
    result = ""
    half = remaining / 2
    rest = remaining % 2

    1.upto(half + rest) {
      result << " "
    }
    result << text
    1.upto(half) {
      result << " "
    }
    return result
  end
  
end

class AstElement
  
  attr_accessor :next
  attr_reader :line
  attr_reader :column
  
  
  def initialize(line, column)
    @line = line
    @column = column
  end
  
end

class IncrementPointer < AstElement
  
  def eval(context)
    context.inc_pointer
    return @next
  end
  
end

class DecrementPointer < AstElement
  
  def eval(context)
    context.dec_pointer
    return @next
  end
  
end

class IncrementValue < AstElement
  def eval(context)
    context.inc_value
    return @next
  end
end

class DecrementValue < AstElement
  def eval(context)
    context.dec_value
    return @next
  end
end

class ReadInput < AstElement
  def eval(context)
    context.set_value(STDIN.getc.bytes.to_a[0])
    return @next
  end
end

class PrintValue < AstElement
  def eval(context)
    print(context.get_value.chr)
    return @next
  end
end

class LoopStart < AstElement
 
  attr_reader :next
  attr_accessor :loopEnd
  
  def eval(context)
    if(context.get_value == 0)
      return @loopEnd
    else
      return @next
    end
  end
end

class LoopEnd < AstElement
  attr_accessor :loopHead
  
  def eval(context)
    if(context.get_value != 0)
      return @loopHead
    else
      return @next
    end
  end
end
