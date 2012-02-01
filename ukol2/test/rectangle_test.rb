require_relative '../lib/rectangle.rb'
require 'test/unit'

class RectangleTest <  Test::Unit::TestCase
  
  def test_constructor_error
    assert_raise RuntimeError do
      Rectangle.new("test", 1, 2, 3)
    end
    
    assert_raise RuntimeError do
      Rectangle.new(5, "test", 2, 3)
    end
    
    assert_raise RuntimeError do
      Rectangle.new(1, 1, "test")
    end
    
    assert_raise RuntimeError do
      Rectangle.new(1, 1, 3, "test")
    end
    
    assert_raise RuntimeError do
      Rectangle.new(3, 1, -1)
    end
    
    assert_raise RuntimeError do
      Rectangle.new(3, 1, 5, -1)
    end
 
  end
  
  def test_constructor_ok
    rect_eql2(Rectangle.new(0, 1, 2), 0, 1, 2)
    rect_eql(Rectangle.new(-5, -2, 5, 0), -5, -2, 5, 0)
    rect_eql(Rectangle.new(6, -5, 0, 0), 6, -5, 0, 0)
  end


  def test_area
    x = Rectangle.new(0,0,5)
    assert_equal(25, x.area(), 'Area does not match')
    
    x = Rectangle.new(0,0,0)
    assert_equal(0, x.area(), 'Area does not match')
    
    x = Rectangle.new(0,0,6)
    assert_equal(36, x.area(), 'Area does not match')
    
    x = Rectangle.new(0, 0, 5, 4)
    assert_equal(20, x.area(), 'Area does not match')
    
    x = Rectangle.new(0, 0, 0, 10)
    assert_equal(0, x.area(), 'Area does not match')
  end
  
  def test_common_rectangle
    x = Rectangle.new(0, 0, 4)
    assert_raise RuntimeError do
      x.common_rectangle("Test123")
    end
    
    y = Rectangle.new(10, 10, 2)
    
    assert_equal(nil, x.common_rectangle(y), 'Common rectangle does not match')
    assert_equal(nil, y.common_rectangle(x), 'Common rectangle does not match')
    
    y = Rectangle.new(0, 2, 2)
    common = x.common_rectangle(y)
    rect_eql(common, 0, 1.5, 2, 1)
    common = y.common_rectangle(x)
    rect_eql(common, 0, 1.5, 2, 1)
    
    y = Rectangle.new(0, 0, 1)
    common = x.common_rectangle(y)
    rect_eql2(common, 0, 0, 1)
    common = y.common_rectangle(x)
    rect_eql2(common, 0, 0, 1)
  end
  
  def rect_eql(rectangle, x, y, width, height)
    assert_not_nil(rectangle, 'Rectangle must not be nil')
    assert_equal(x, rectangle.x, 'X coordinate does not match')
    assert_equal(y, rectangle.y, 'Y coordinate does not match')
    assert_equal(width, rectangle.width, 'Width must match')
    assert_equal(height, rectangle.height, 'Height must match')
  end
  
  def rect_eql2(rectangle, x, y, width)
    return rect_eql(rectangle, x, y, width, width)
  end
  
end