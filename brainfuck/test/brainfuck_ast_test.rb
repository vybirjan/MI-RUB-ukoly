require_relative '../lib/brainfuck_ast.rb'
require 'test/unit'

class BrainfuckContextText <  Test::Unit::TestCase
  
  def test_initialize
    c = BrainfuckContext.new
    
    30000.times {
      assert_equal(0, c.get_value)
      c.inc_pointer
    }
  end
  
  def test_pointer_bounds
    c = BrainfuckContext.new
    
    assert_raise RangeError do
      c.dec_pointer
    end
    
    30000.times {
      c.inc_pointer
    }
    
    assert_raise RangeError do
      c.inc_pointer
    end
  end
  
  def test_dec_value
    c = BrainfuckContext.new
    
    expected = 0
    
    256.times {
      assert_equal(expected, c.get_value)
      c.dec_value
      expected = (expected - 1) % 256
    }
  end
  
  def test_inc_value
    c = BrainfuckContext.new
    
    expected = 0
    
    256.times {
      assert_equal(expected, c.get_value)
      c.inc_value
      expected = (expected + 1) % 256
    }
  end
  
  def test_set
    c = BrainfuckContext.new
    
    assert_raise ArgumentError do
      c.set_value(-1)
    end
    
    assert_raise ArgumentError do
      c.set_value(256)
    end
    
    30000.times {
      val = rand(256)
      c.set_value(val)
      assert_equal(val, c.get_value)
      c.inc_pointer
    }
    
  end

end