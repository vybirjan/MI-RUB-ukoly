require_relative 'brainfuck_ast.rb'

INC_POINTER = '>'
DEC_POINTER = '<'
INC_VALUE = '+'
DEC_VALUE = '-'
PRINT_VALUE = '.'
READ_VALUE = ','
LOOP_START = '['
LOOP_END = ']'
NEW_LINE = "\n"

class BrainfuckParseError < RuntimeError
  
  attr_reader :line
  attr_reader :column
  
  def initialize(message, line, column)
    super(message)
    @line = line
    @column = column
  end
end

class BrainfuckParser
  
  def initialize
    @current_line = 1
    @current_column = 1
    @first_command = nil
    @previous_command = nil
    @loop_starts = []
  end
  
  def parse_code(text)
    text.each_char {|char|
      case char
        when INC_POINTER
          initialize_element(IncrementPointer.new(@current_line, @current_column))
        when DEC_POINTER
          initialize_element(DecrementPointer.new(@current_line, @current_column))
        when INC_VALUE
          initialize_element(IncrementValue.new(@current_line, @current_column))
        when DEC_VALUE
          initialize_element(DecrementValue.new(@current_line, @current_column))
        when PRINT_VALUE
          initialize_element(PrintValue.new(@current_line, @current_column))
        when READ_VALUE
          initialize_element(ReadInput.new(@current_line, @current_column))
        when LOOP_START
          case_loop_start
        when LOOP_END
          case_loop_end
        when NEW_LINE
          @current_line = @current_line + 1
          @current_column = 1
      else
        #ignore all other characters
      end
      @current_column = @current_column + 1
    }
    return self
  end
  
  def get_start
    if(@previous_command.is_a?(LoopEnd))
      @loop_starts.pop
    end
    
    if(!@loop_starts.empty?)
      start = @loop_starts.pop
      raise BrainfuckParseError.new("Unexpected end of file - unclosed loop found", start.line, start.column)
    end
    
    return @first_command
  end
  
  private
  
  def initialize_element(elm)
    # set as first command if its first
    if(@first_command == nil)
      @first_command = elm
    end
    
    #finish loop pointers
    if(@previous_command.is_a?(LoopEnd))
    
      if(@loop_starts.empty?)
        raise BrainfuckParseError.new("Unexpected loop end - missing matching loop start", @current_line, @current_column)
      end
      
      loopStart = @loop_starts.pop
      loopStart.loopEnd = elm
    end
    
    #link previous command to this one
    if(@previous_command != nil)
      @previous_command.next = elm
    end
    @previous_command = elm
  end
  
  def case_loop_start
    start = LoopStart.new(@current_line, @current_column)
    initialize_element(start)
    @loop_starts.push(start)
  end
  
  def case_loop_end
    
    loopEnd = LoopEnd.new(@current_line, @current_column)
    initialize_element(loopEnd)
    
    if(@loop_starts.empty?)
      raise BrainfuckParseError.new("Unexpected loop end - missing matching loop start", @current_line, @current_column)
    end
    
    loopStart = @loop_starts.last
    
    loopEnd.loopHead = loopStart.next
  end
end
