require_relative '../lib/rectangle.rb'


def checkNotNegative(number)
  if(number < 0)
    raise ArgumentError
  end
end

begin
  puts "Prunik ctvercu"
  puts "===============\n"
  
  puts "Zadej delku hrany prvniho ctverce:"
  first_width = Float(gets.chomp)
  checkNotNegative(first_width)
  
  puts "Zadej x-ovou souradnici prvniho ctverce:"
  first_x = Float(gets.chomp)
  
  puts "Zadej y-ovou souradnici prvniho ctverce:"
  first_y = Float(gets.chomp)
  
  
  puts "Zadej delku hrany druheho ctverce:"
  second_width = Float(gets.chomp)
  checkNotNegative(first_width)
  
  puts "Zadej x-ovou souradnici druheho ctverce:"
  second_x = Float(gets.chomp)
  
  puts "Zadej y-ovou souradnici druheho ctverce:"
  second_y = Float(gets.chomp)
  
  first = Rectangle.new(first_x, first_y, first_width)
  second = Rectangle.new(second_x, second_y, second_width)
  
  intersection = first.common_rectangle(second)
  
  if(intersection == nil)
    puts "Ctverce se ani nedotykaji"
  else
    puts "Obsah sjednoceni ctvercu je " + (first.area + second.area - intersection.area).to_s
  end
  
rescue ArgumentError => e
  puts "Spatny vstup"
end