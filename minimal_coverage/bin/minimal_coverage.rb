require_relative "../lib/line.rb"
require_relative "../lib/combination_generator.rb"

class Input
  
  attr_reader :base
  attr_reader :lines
  
  def initialize(base_line, lines)
    @base = base_line
    @lines = lines
  end
  
end

def read_input
  gets #firs blank line
  
  #base line
  base = Line.new(0, Integer(gets.chomp))
  index = 0
  lines = Array.new
  
  loop do
    line = gets.chomp.split(" ")
    left = Integer(line[0])
    right = Integer(line[1])
    
    #end reading when read line 0 0
    if(left == 0 && right == 0)
      break
    else
      lines[index] = Line.new(left, right)
      index = index + 1
    end
  end
  
  return Input.new(base, lines)
end

def solve(input)
  gen = CombinationGenerator.new(input.lines)
  1.upto(input.lines.length) {|items|
    combinations = gen.generate_combinations(items)
    combinations.each{|c|
      if(input.base.covered_by?(c))
        return c
      end
    }
  }
  
  return nil
end


num_of_tests = Integer(gets.chomp)
inputs = Array.new(num_of_tests)

0.upto(num_of_tests - 1) {|i|
  inputs[i] = read_input()
}

first = false

inputs.each {|input|
  if(!first)
    puts ""
    first = false
  end

  solution = solve(input)
  if(solution == nil)
    puts "0"
  else
    print solution.length
    solution.sort! {|a,b|
      a.left <=> b.left
    }
    solution.each {|line|
      print "\n" + line.left.to_s + " " + line.right.to_s 
    }
    puts ""
  end
  
}

