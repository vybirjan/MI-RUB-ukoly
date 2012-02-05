require_relative '../lib/brainfuck_parser.rb'
require 'test/unit'
require 'mocha'

class BrainfuckParserTest <  Test::Unit::TestCase
  
  def test_empty
    parser = BrainfuckParser.new
    assert_nil(parser.get_start)
  end
  
  def test_types
    parser = BrainfuckParser.new
    parser.parse_code(">")
    assert parser.get_start.is_a?(IncrementPointer)
    
    parser = BrainfuckParser.new
    parser.parse_code("<")
    assert parser.get_start.is_a?(DecrementPointer)
    
    parser = BrainfuckParser.new
    parser.parse_code("+")
    assert parser.get_start.is_a?(IncrementValue)
    
    parser = BrainfuckParser.new
    parser.parse_code("-")
    assert parser.get_start.is_a?(DecrementValue)
    
    parser = BrainfuckParser.new
    parser.parse_code(".")
    assert parser.get_start.is_a?(PrintValue)
    
    parser = BrainfuckParser.new
    parser.parse_code(",")
    assert parser.get_start.is_a?(ReadInput)
    
    parser = BrainfuckParser.new
    parser.parse_code("[]")
    ret = parser.get_start
    assert ret.is_a?(LoopStart)
    assert ret.next.is_a?(LoopEnd)
  end
  
  def test_parse_errors
    parser = BrainfuckParser.new
    parser.parse_code("[>>>++<<")
    assert_raise BrainfuckParseError do
      parser.get_start
    end
    
    parser = BrainfuckParser.new
    assert_raise BrainfuckParseError do
      parser.parse_code("]>>>++<<")
    end
    
    parser = BrainfuckParser.new
    parser.parse_code("[>>>[++[<<]]")
    assert_raise BrainfuckParseError do
      parser.get_start
    end
    
    parser = BrainfuckParser.new
    assert_raise BrainfuckParseError do
      parser.parse_code("[>>>]++]<<")
    end
  end
  
  def test_parse_simple
    parser = BrainfuckParser.new
    parser.parse_code("><+-.,")
    ret = parser.get_start
    
    assert ret.is_a?(IncrementPointer)
    ret = ret.next
    assert ret.is_a?(DecrementPointer)
    ret = ret.next
    assert ret.is_a?(IncrementValue)
    ret = ret.next
    assert ret.is_a?(DecrementValue)
    ret = ret.next
    assert ret.is_a?(PrintValue)
    ret = ret.next
    assert ret.is_a?(ReadInput)
    ret = ret.next
    assert_nil ret
  end
  
  def test_parse_loop
    parser = BrainfuckParser.new
    parser.parse_code(">[+]<")
    ret = parser.get_start
    
    assert ret.is_a?(IncrementPointer)
    ret = ret.next
    assert ret.is_a?(LoopStart)
    assert ret.loopEnd.is_a?(DecrementPointer)
    ret = ret.next
    assert ret.is_a?(IncrementValue)
    ret = ret.next
    assert ret.is_a?(LoopEnd)
    assert ret.loopHead.is_a?(IncrementValue)
    ret = ret.next
    assert ret.is_a?(DecrementPointer)
    ret = ret.next
    assert_nil ret
    
  end
  
end