# Implicit block
# All Ruby methods take implicit blocks that can be passed in upon method invocation. That is why `yield` on line 5 can yield to invoke the block passed in implicitly.

def my_method
  yield(3)
end

my_method { |num| puts num }

puts

# Explicit block
# Blocks can be passed in explicitly to a method definition as an argument if prepended with `&`, which turns that block into a Proc. The Proc object can then be called later with `Proc#call`. Note that the block argument passed to the method invocation still remains as an implicit block that can be `yield`ed to

already_a_proc = Proc.new { |num| puts num }

def my_other_method(proc, &anything) # Note: &block is expected to be the last parameter in a method definition.
  anything.call(3) # This calls the proc object saved in `anything`
  yield(3) # This yields to the block passed to the method invocation, which is also the same block that is converted to a proc object and saved in `anything`
  proc.call(2) # This calls the proc object that was passed as an argument to the method invocation.
end

my_other_method(already_a_proc) { |num| puts num }


# Scoping notes:

snacks = ['scone', 'pancake']
snack_proc = Proc.new { p snacks }
1.times { snack_proc.call}
snacks = 'waffle'

snack_proc.call

cookie_proc = Proc.new { p cookie }
cookie = ['chocolate', 'ginger']
cookie_proc.call

# Notes on above:
# - The block created and executed on line 29 has access to snacks, but will use the value of snacks at execution, which would be the 2-element array
# - Under the same rule, when `snack_proc`` is executed, the then-current value of `snacks` will be printed, which is 'waffle'
# - Procs can save blocks as variables for later execution 
# - Though closures bring around variables in their surrounding context in their bindings, any variables referenced in closures must be initialized before the closure. Despite the fact that `snack_proc`'s call on line 33 results in 'waffle' being `snack`'s value (even though the block that is executed was created before `snacks` was reassigned to 'waffle'), line 35 will throw an exception when `cookie_proc` is called: the local variable `cookie` was not yet initialized when the block was created