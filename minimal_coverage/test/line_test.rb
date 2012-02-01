require_relative '../lib/line.rb'
require 'test/unit'

class LineTest <  Test::Unit::TestCase
  
  def test_constructor_error
    assert_raise RuntimeError do
      Line.new(5, 3)
    end
    
    assert_raise RuntimeError do
      Line.new(0, -5)
    end
    
    assert_raise RuntimeError do
      Line.new(-5, -6)
    end
    
    assert_raise RuntimeError do
      Line.new(0, 0)
    end
  end
  
  def test_constructor_ok
    line = Line.new(0, 5)
    assert_equal(0, line.left, "Left does not match")
    assert_equal(5, line.right, "Right does not match")
    
    line = Line.new(-5, 5)
    assert_equal(-5, line.left, "Left does not match")
    assert_equal(5, line.right, "Right does not match")
    
    line = Line.new(-5, -1)
    assert_equal(-5, line.left, "Left does not match")
    assert_equal(-1, line.right, "Right does not match")
  end
  
  def test_covers
    line = Line.new(0, 6)
    0.upto(6) {|index|
      assert(line.covers(index))
    }
    assert(!line.covers(-1))
    assert(!line.covers(7))
    
    line = Line.new(-10, 50)
    -10.upto(50) {|index|
      assert(line.covers(index))
    }
    assert(!line.covers(-11))
    assert(!line.covers(51))
  end
  
  
  def test_coverage_not_overlapping_single
    line1 = Line.new(0, 5)
    line2 = Line.new(6, 10)
    
    assert(!line1.covered_by?(line2))
    assert(!line2.covered_by?(line1))
  end
  
  def test_coverage_partially_overlapping_single
    line1 = Line.new(0, 5)
    line2 = Line.new(3, 10)
    
    assert(!line1.covered_by?(line2))
    assert(!line2.covered_by?(line1))
  end
  
  def test_coverage_equal_single
    line1 = Line.new(-2, 2)
    line2 = Line.new(-2, 2)
    
    assert(line1.covered_by?(line2))
    assert(line2.covered_by?(line1))
  end
  
  def test_coverage_inside_single
    line1 = Line.new(0, 10)
    line2 = Line.new(3, 7)
    
    assert(!line1.covered_by?(line2))
    assert(line2.covered_by?(line1))
  end
  
  def test_coverage_not_overlapping_multi
    base = Line.new(0, 10)
    line1 = Line.new(-5, -3)
    line2 = Line.new(-2, -1)
    line3 = Line.new(11, 12)
    
    assert(!base.covered_by?([line1, line2, line3]))
  end
  
  def test_coverage_partially_overlapping_multi
    base = Line.new(0, 10)
    line1 = Line.new(-5, 1)
    line2 = Line.new(-2, 3)
    line3 = Line.new(9, 12)
    
    assert(!base.covered_by?([line1, line2, line3]))
    
    base = Line.new(0, 10)
    line1 = Line.new(0, 10)
    line2 = Line.new(0, 10)
    line3 = Line.new(12, 15)
    
    assert(base.covered_by?([line1, line2, line3]))
  end
  
  def test_coverage_equal_multi
    base = Line.new(0, 10)
    line1 = Line.new(0, 10)
    line2 = Line.new(0, 10)
    line3 = Line.new(0, 10)
    
    assert(base.covered_by?([line1, line2, line3]))
  end
  
  def test_coverage_inside_not_overlapping_multi
    base = Line.new(0, 10)
    line1 = Line.new(0, 2)
    line2 = Line.new(2, 3)
    line3 = Line.new(3, 10)
    
    assert(base.covered_by?([line1, line2, line3]))
  end
  
  def test_coverage_inside_overlapping_multi
    base = Line.new(0, 10)
    line1 = Line.new(0, 4)
    line2 = Line.new(2, 6)
    line3 = Line.new(5, 10)
    
    assert(base.covered_by?([line1, line2, line3]))
    
    base = Line.new(0, 10)
    line1 = Line.new(-5, 2)
    line2 = Line.new(1, 6)
    line3 = Line.new(5, 15)
    
    assert(base.covered_by?([line1, line2, line3]))
  end
  
end