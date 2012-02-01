class Pentomino
  
  attr_reader :arrays
  attr_reader :rows
  attr_reader :cols
  
  def self.read_from_console
    arr = Array.new
    
    line = 0
    max_line_length = 0
    
    while(!(radek = gets.chomp).empty?) do
        arr[line] = Array.new
        
        index = 0
        radek.split("").each do |c|
          if(!c.eql?" ")
            arr[line][index] = true
          end
          index = index + 1
        end
        
        if(index > max_line_length)
          max_line_length = index
        end
        
        line = line + 1
      end
      
      0.upto(line - 1) {|i|
        0.upto(max_line_length - 1) {|j|
          if(arr[i][j] == nil)
            arr[i][j] = false
          end
        }
      }
      
      
      return Pentomino.new(arr)
    end
    
    def initialize(array)
      @arrays = Array.new(4)
      
      @rows = 0
      @cols = 0
      
      if(!array.is_a?(Array))
        raise ArgumentError, "Argument must be array"
      end
      
      array.each {|row|
        @rows = @rows + 1
        
        if(!row.is_a?(Array))
          raise ArgumentError, "Each element of array must be also array (2D array)"
        end 
        
        items = 0
        row.each {
          items = items + 1
        }
        
        if(@cols == 0)
          @cols = items
        else
          if(@cols != items)
            raise ArgumentError, "Unexpected number of elements in row, expected " + @cols.to_s + ", got " + items.to_s
          end
        end 
      }
      
      @arrays[0] = array
      1.upto(3) {|i|
        @arrays[i] = rotate_right(@arrays[i-1]) 
      }
    end
    
    def to_s
      ret = ""
      @arrays[0].each{|line|
        ret = ret + "|"
        line.each{|item|
          if(item)
            ret = ret + "X"
          else
            ret = ret + " "
          end
          ret = ret + "|"
        }
        ret = ret + "\n"
      }
      return ret
    end
    
    def rotate_right(array)
      
      cols = array[0].length
      rows = array.length
      
      x = Array.new()
      0.upto(cols-1) {|i|
        x[i] = Array.new(rows)
      }
      
      0.upto(rows-1) {|i|
        0.upto(cols-1) {|j|
          x[j][rows-i-1] = array[i][j]
        }
      }
      
      return x
    end
    
    def can_write_to(matrix, xloc, yloc, rotation = 0)
      
      if(rotation < 0 || rotation > 3)
        raise ArgumentError, "Rotation must be 0, 1, 2, 3"
      end
      
      rows = @rows
      cols = @cols
      
      if(rotation == 1 || rotation == 3)
        rows = @cols
        cols = @rows
      end
      
      #check matrix fits horizontally
      if(matrix.length - xloc - rows < 0)
        return false
      else
        #check matrix fits vertically
        if(matrix[xloc].length - yloc - cols < 0)
          return false
        else
          #check all cells to which item will be written are nil
          0.upto(rows-1) {|x|
            0.upto(cols-1) {|y|
              if(@arrays[rotation][x][y] == true && matrix[x+xloc][y+yloc] != nil)
                return false
              end
            }
          }
          return true
        end
      end
    end
    
    def write_to(matrix, xloc, yloc, rotation = 0, value = "X")
      
      if(rotation < 0 || rotation > 3)
        raise ArgumentError, "Rotation must be 0, 1, 2, 3"
      end
      
      rows = @rows
      cols = @cols
      
      if(rotation == 1 || rotation == 3)
        rows = @cols
        cols = @rows
      end
      
      
      0.upto(rows-1) {|x|
        0.upto(cols-1) {|y|
          if(@arrays[rotation][x][y]) 
            matrix[x+xloc][y+yloc] = value
          end
        }
      }
      
    end
    
    def remove_from(matrix, xloc, yloc, rotation = 0)
      if(rotation < 0 || rotation > 3)
        raise ArgumentError, "Rotation must be 0, 1, 2, 3"
      end
      
      rows = @rows
      cols = @cols
      
      if(rotation == 1 || rotation == 3)
        rows = @cols
        cols = @rows
      end
      
      
      0.upto(rows-1) {|x|
        0.upto(cols-1) {|y|
          if(@arrays[rotation][x][y]) 
            matrix[x+xloc][y+yloc] = nil
          end
        }
      }
    end
    
  end
  

  
  
  
  

