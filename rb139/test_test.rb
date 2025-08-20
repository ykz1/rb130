# Code to be tested
class Calculator
  def self.add(a, b)
    a + b
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class CalculatorTest < Minitest::Test

  def test_add
    a = 1
    b = 2
    sum = a + b
    assert_equal(sum, Calculator.add(a, b))
  end

  def test_add_arguments
    assert_raises(ArgumentError) do 
      Calculator.add(3)
    end
    assert_raises(ArgumentError) do
      Calculator.add(3, 4, 5)
    end
  end
end

# Set up: assigning values to a, b, and sum all are setup
# Execute code: Calculater.add(a, b) is executing code against our testing object
# Assert: assert_equal is where we assert that the executed code should result in some expected value
# Teardown: not necessary here