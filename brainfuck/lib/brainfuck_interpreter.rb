require_relative 'brainfuck_ast.rb'

class BrainfuckInterpreter
  
  def self.interpret(ast, context)
    current = ast
    
    while current != nil
      begin
        current = current.eval(context)
      rescue RuntimeError => e
        puts 'Error on line ' + current.line.to_s + ', column ' + current.column.to_s + ': ' + e.message
      end
    end
    
  end
  
end