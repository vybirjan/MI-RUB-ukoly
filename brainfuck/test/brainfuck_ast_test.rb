require_relative '../lib/brainfuck_ast.rb'
require 'test/unit'
require 'mocha'

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
  
  def test_incr_ptr
    context = mock()
    context.expects(:inc_pointer)
    
    inc = IncrementPointer.new(1, 2)
    inc.next = 5
    
    assert_equal(1, inc.line)
    assert_equal(2, inc.column)
    
    assert_equal(5, inc.eval(context))
  end
  
  def test_dec_ptr
    context = mock()
    context.expects(:dec_pointer)
    
    inc = DecrementPointer.new(1, 2)
    inc.next = 5
    
    assert_equal(1, inc.line)
    assert_equal(2, inc.column)
    
    assert_equal(5, inc.eval(context))
  end
  
  def test_inc_value
    context = mock()
    context.expects(:inc_value)
    
    inc = IncrementValue.new(1, 2)
    inc.next = 5
    
    assert_equal(1, inc.line)
    assert_equal(2, inc.column)
    
    assert_equal(5, inc.eval(context))
  end
  
  def test_dec_value
    context = mock()
    context.expects(:dec_value)
    
    inc = DecrementValue.new(1, 2)
    inc.next = 5
    
    assert_equal(1, inc.line)
    assert_equal(2, inc.column)
    
    assert_equal(5, inc.eval(context))
  end
  
  def test_loop_start
    context = mock()
    context.expects(:get_value).returns(1)
    context.expects(:get_value).returns(0)
    
    obj = LoopStart.new(5, 6)
    
    assert_equal(5, obj.line)
    assert_equal(6, obj.column)
    
    obj.next = true
    obj.loopEnd = false
    
    assert !obj.eval(context)
    assert obj.eval(context)
  end
  
  def test_loop_end
    context = mock()
    context.expects(:get_value).returns(1)
    context.expects(:get_value).returns(0)
    
    obj = LoopEnd.new(5, 6)
    
    assert_equal(5, obj.line)
    assert_equal(6, obj.column)
    
    obj.next = true
    obj.loopHead = false
    
    assert obj.eval(context)
    assert !obj.eval(context)
  end
  
  def test_print
    context = mock()
    context.expects(:get_value).returns(" ")
    
    obj = PrintValue.new(5, 6)
    
    assert_equal(5, obj.line)
    assert_equal(6, obj.column)
    
    obj.eval(context)
    
  end
  
end