require_relative '../lib/brainfuck_interpreter.rb'
require 'test/unit'
require 'mocha'

class BrainfuckInterpreterTest <  Test::Unit::TestCase
  
  def test_interpreter
    context = mock()
    ast = mock()
    ast.expects(:eval).with(context).at_most(3).returns(ast)
    ast.expects(:eval).with(context).returns(nil)
    
    BrainfuckInterpreter.interpret(ast, context)
  end
  
end