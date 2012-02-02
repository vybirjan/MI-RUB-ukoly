require_relative '../lib/pentomino.rb'
require 'test/unit'

class PentominoTest <  Test::Unit::TestCase
  
  def test_constructor
    assert_raise ArgumentError do
      Pentomino.new
    end
    
    assert_raise ArgumentError do
      Pentomino.new(5)
    end
    
    assert_raise ArgumentError do
      Pentomino.new([[2, 3], 1])
    end
  end
  
  def test_constructor2
    pentomino = Pentomino.new([[true, true], [true, false], [true, false]])
    assert_equal(3, pentomino.rows)
    assert_equal(2, pentomino.cols)
  end
  
  def test_can_write_to
    p = Pentomino.new([[true, true], [true, false], [true, false]])
    
    assert_raise ArgumentError do
      p.can_write_to(1, 0, 6, 4);
    end
    
    assert_raise ArgumentError do
      p.can_write_to(1, 0, 6, -1);
    end
    
    too_small = [[nil, nil], [nil, nil]]
    
    assert(!p.can_write_to(too_small, 0, 0, 0))
    
    wrong_dimenstions = [[nil, nil], [nil, nil], [nil, nil]]
    
    assert(!p.can_write_to(wrong_dimenstions, 0, 0, 1))
    assert(!p.can_write_to(wrong_dimenstions, 0, 0, 3))
    assert(!p.can_write_to(wrong_dimenstions, 1, 0, 0))
    assert(!p.can_write_to(wrong_dimenstions, 0, 1, 0))
    assert(!p.can_write_to(wrong_dimenstions, 1, 0, 2))
    assert(!p.can_write_to(wrong_dimenstions, 0, 1, 2))
    
    assert(p.can_write_to(wrong_dimenstions, 0, 0, 0))
    assert(p.can_write_to(wrong_dimenstions, 0, 0, 2))
    
    full = [[true, 1], ["nil", nil], [nil, nil]]
    assert(!p.can_write_to(full, 0, 0, 0))
    
    ok = [[nil, nil], [nil, 1], [nil, 1]]
    assert(p.can_write_to(ok, 0, 0, 0))
  end
  
  def test_write_to_matrix
     p = Pentomino.new([[true, true], [true, false], [true, false]])
     a = [Array.new(2), Array.new(2), Array.new(2)]
     
     p.write_to(a, 0, 0, 0, "X")
     
     assert_equal("X", a[0][0])
     assert_equal("X", a[0][1])
     assert_equal("X", a[1][0])
     assert_nil(a[1][1])
     assert_equal("X", a[2][0])
     assert_nil(a[2][1])
     
     a = [Array.new(2), Array.new(2), Array.new(2)]
     p.write_to(a, 0, 0, 2, "X")
     
     assert_nil(a[0][0])
     assert_equal("X", a[0][1])
     assert_nil(a[1][0])
     assert_equal("X", a[1][1])
     assert_equal("X", a[2][0])
     assert_equal("X", a[2][1])
     
     a = [Array.new(3), Array.new(3)]
     p.write_to(a, 0, 0, 1, "X")
     
     assert_equal("X", a[0][0])
     assert_equal("X", a[0][1])
     assert_equal("X", a[0][2])
     assert_nil(a[1][0])
     assert_nil(a[1][1])
     assert_equal("X", a[1][2])
     
     a = [Array.new(3), Array.new(3)]
     p.write_to(a, 0, 0, 3, "X")
     
     assert_equal("X", a[0][0])
     assert_nil(a[0][1])
     assert_nil(a[0][2])
     assert_equal("X", a[1][0])
     assert_equal("X", a[1][1])
     assert_equal("X", a[1][2])
 end
 
 def test_remove_from_matrix
   p = Pentomino.new([[true, true], [true, false], [true, false]])
   p = Pentomino.new([[true, true], [true, false], [true, false]])
     a = [["X", "X"], ["X", "X"],["X", "X"]]
     
     p.remove_from(a, 0, 0, 0)
     
     assert_nil(a[0][0])
     assert_nil(a[0][1])
     assert_nil(a[1][0])
     assert_equal("X", a[1][1])
     assert_nil(a[2][0])
     assert_equal("X", a[2][1])
     
     a = [["X", "X"], ["X", "X"],["X", "X"]]
     p.remove_from(a, 0, 0, 2)
     
     assert_equal("X", a[0][0])
     assert_nil(a[0][1])
     assert_equal("X", a[1][0])
     assert_nil(a[1][1])
     assert_nil(a[2][0])
     assert_nil(a[2][1])
     
     a = [["X", "X", "X"], ["X", "X", "X"]]
     p.remove_from(a, 0, 0, 1)
     
     assert_nil(a[0][0])
     assert_nil(a[0][1])
     assert_nil(a[0][2])
     assert_equal("X", a[1][0])
     assert_equal("X", a[1][1])
     assert_nil(a[1][2])
     
     a = [["X", "X", "X"], ["X", "X", "X"]]
     p.remove_from(a, 0, 0, 3)
     
     assert_nil(a[0][0])
     assert_equal("X", a[0][1])
     assert_equal("X", a[0][2])
     assert_nil(a[1][0])
     assert_nil(a[1][1])
     assert_nil(a[1][2])
 end
  
end