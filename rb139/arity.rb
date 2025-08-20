# Arity refers to how Ruby handles a mismatch between arguments passed to a closure's invocation, and the parameters defined by the closure.

# Lambdas and methods have strict arity. The number of arguments passed must match the number of parameters defined.

# Blocks and procs have lenient arity. The number of arguments passed do not need to match the number of parameters defined. Any extra arguments will be ignored, and missing arguments / defined parameters with no matching parameters passed will be initialized to the value `nil`.


# Here is an example of blocks having lenient arity:

def some_method
  yield(3) # 3 should be printed, argument passed matches parameters defined in the block
  yield # nil will be printed, no arguments passed despite one parameter defined and so that parameter is initialized and set to `nil`
  yield(3, 4, 5) # 3 should be printed again, extra arguments are passed and are ignored by the block
end

some_method { |num| p num }

puts

# Here is the same example, except with a Proc object, showing Procs also having lenient arity:

some_proc = Proc.new { |num| p num }

some_proc.call(3) # => 3 is printed
some_proc.call # => nil printed because no argument to assign to `num`
some_proc.call(3, 4, 5) # => 3 printed and extra arguments ignored


puts

# Here is the same example, except with a lambda, showing that lambdas have strict arity and will throw exceptions if the number of arguments passed does not match the number of parameters defined by the closure:

some_lambda = lambda { |num| p num }

some_lambda.call(3) # => 3 is printed
some_lambda.call rescue puts $! # => exception thrown, wrong number of arguments
some_lambda.call(3, 4, 5) rescue puts $! # => exception thrown, wrong number of arguments

# Lastly, we can see that methods similarly have strict arity:

some_method("extra argument") rescue puts $! # => exception thrown, wrong number of arguments