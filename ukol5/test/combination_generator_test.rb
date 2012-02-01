require_relative '../lib/combination_generator.rb'
require 'test/unit'

class CombinationGeneratorTesst <  Test::Unit::TestCase
  
  def test_fail
    generator = CombinationGenerator.new([1, 2])
    
    #negative number
    assert_raise RuntimeError do
      generator.generate_combinations(-5)
    end
    
    #zero
    assert_raise RuntimeError do
      generator.generate_combinations(0)
    end
    
    #more than items
    assert_raise RuntimeError do
      generator.generate_combinations(3)
    end
  end
  
  def test_combinations
    generator = CombinationGenerator.new([1, 2, 3, 4])
    
    single = generator.generate_combinations(1)
    
    assert_kind_of(Array, single, "Result must be array")
    assert_equal(4, single.length)
    assert(single.include?([1]))
    assert(single.include?([2]))
    assert(single.include?([3]))
    assert(single.include?([4]))
    
    two = generator.generate_combinations(2)
    
    assert_kind_of(Array, two, "Result must be array")
    assert_equal(6, two.length)
    assert(two.include?([1, 2]))
    assert(two.include?([1, 3]))
    assert(two.include?([1, 4]))
    assert(two.include?([2, 3]))
    assert(two.include?([2, 4]))
    assert(two.include?([3, 4]))
    
    
    three = generator.generate_combinations(3)
    
    assert_kind_of(Array, three, "Result must be array")
    assert_equal(4, three.length)
    assert(three.include?([1, 2, 3]))
    assert(three.include?([1, 2, 4]))
    assert(three.include?([1, 3, 4]))
    assert(three.include?([2, 3, 4]))
    
    
    
    four = generator.generate_combinations(4)
    
    assert_kind_of(Array, four, "Result must be array")
    assert_equal(1, four.length)
    assert(four.include?([1, 2, 3, 4]))
  end
end