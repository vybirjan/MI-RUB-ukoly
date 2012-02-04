require_relative 'brainfuck_ast.rb'

class BrainfuckCTranslator
  
  def self.to_c_source(ast)
    source = ""
    source << PROLOG
    
    element = ast
    tabcount = 1
    
    while(element != nil)
      source << tabs(tabcount)
      case element
        when IncrementValue
          source << "memory[pointer]++;\n"
        when DecrementValue
          source << "memory[pointer]--;\n"
        when IncrementPointer
          source << "pointer++;\n"
        when DecrementPointer
          source << "pointer--;\n"
        when ReadInput
          source << "memory[pointer] = getchar();\n"
        when PrintValue
          source << "putchar(memory[pointer]);\n"
        when LoopStart
          source << "while(memory[pointer] != 0) {\n"
          tabcount = tabcount + 1
        when LoopEnd
          source << "}\n"
          tabcount = tabcount - 1
      end
      element = element.next
    end
    
    source << EPILOG
  end
  
  private
  
  def self.tabs(count)
    ret = ""
    1.upto(count) do
      ret << "\t"
    end
    return ret
  end
  
  PROLOG = "#include <stdio.h>\n\nint main(void)\n{\n\tstatic char memory[30000];\n\tint pointer = 0;\n"
  EPILOG = "\treturn 0;\n}"
  
end