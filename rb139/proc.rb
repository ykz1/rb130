def create_greeter(name)
  Proc.new { puts "Hello, #{name}!" }
end

name = "World"
greeter = create_greeter("Kyle")

name = "Launch School"
greeter.call

# "Hello, Kyle" will be printed.

# What is happening here:
# 5: local variable `name` initialized and set to value 'World'
# 6: local variable greeter initialized and set to point to the Proc object returned by `create_greeter`` method.
# 2: The Proc object block's binding includes everything within `create_greeter`'s method definition on lines 1 to 3, but its binding is limited to these lines because methods have self-contained scope. The `name` variable in this scope is different from the `name` variable initialized on line 5. 
# 8: when `name` is reassigned to 'Launch School', it is the `name` variable initialized on line 5 that is reassigned, and not the `name` variable on line 1 within `create_greeter`'s method definition.
# 9: when we call the Proc object referenced by `greeter`, the closure on line 2 is executed, and the `name` here is still `Kyle` because that's what it was assigned to when `create_greeter` was called on line 6.