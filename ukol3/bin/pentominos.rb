  require_relative "../lib/pentomino.rb"
  
  def init2d(arr, length)
    0.upto(arr.length-1) {|i|
      arr[i] = Array.new(length)
    }
  end
  
  def printArr(array)
    array.each {|row|
      print "|"
      row.each{|cell|
        if(cell==nil)
          print " |"
        else
          print cell.to_s + "|" 
        end
      }
      puts
    }
  end
  
  
  
  def next_position(array, x, y)
    if(x >= (array.length - 1) && y >= (array[x].length - 1))
      return nil
    end
    
    if(y >= array[x].length - 1)
      return [x + 1, 0]
    else
      return [x, y + 1]
    end
  end
  
  def array_filled(array)
    array.each{|row|
      row.each{|cell|
        if(cell == nil)
          return false
        end
      }
    }
    return true
  end  
  
  
  def fill_rest(array, pentominos, currentx, currenty, shapes, shape_num)
    nextPos = next_position(array, currentx, currenty)
    if(nextPos == nil)
      return array_filled(array)
    else
      return fill(array, pentominos, nextPos[0], nextPos[1], shapes, shape_num)
    end
  end
  
  shapes = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split("")
  
  def fill(array, pentominos, xstart, ystart, shapes, shape_num = 0)
    pentominos.each{|pentomino|
      0.upto(3) {|rotation|
        if(pentomino.can_write_to(array, xstart, ystart, rotation))
          pentomino.write_to(array, xstart, ystart, rotation, shapes[shape_num])
          if(fill_rest(array, pentominos, xstart, ystart, shapes, shape_num + 1))
            #array was filled with current rotation of pentomino
            return true
          else
            #array could not be filled, remove it and try again
            pentomino.remove_from(array, xstart, ystart, rotation)
          end   
        end
      }
    }
    
    
    #array could not be filled with pentomino at this location, lets try it without it
    return fill_rest(array, pentominos, xstart, ystart, shapes, shape_num)
  end
  
  
  puts "Insert board width:"
  width = Integer(gets.chomp)
  
  puts "Insert board height:"
  height = Integer(gets.chomp)
  
  
  test = Array.new(height)
  
  init2d(test, width)
  
  puts "Area to fill\n"
  
  printArr(test)
  
  pentominos = Array.new
  
  loop do
    puts "\nInsert pentomino shape"
    pentominos[pentominos.length] = Pentomino.read_from_console
    
    puts "Read next? (Y/*)"
    break unless gets.chomp.eql?("Y")
  end
  
  
  puts "Starting"
  
  if(fill(test, pentominos, 0, 0, shapes))
    puts "OK"
    printArr(test)
  else
    puts "Failed to fill area"
  end
  
