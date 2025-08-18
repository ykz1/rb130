

def double(arg)
  arg * 2
end

double = Proc.new { |arg| arg * 2 }

p [1, 2, 3].map(&double)
# This takes the Proc object `double` and converts it to a block to pass to `#map`
# This is effectively the same as...
p [1, 2, 3].map { |element| double(element)}
# and also the same as...
p [1, 2, 3].map { |element| element * 2 }
# Instead of having to define the block at `map`'s invocation, we're able to move the implementation details for this block to a Proc object `double` to be defined at a different time than `map`'s invocation. We are also able to reuse the block that is saved in `double` to be used as a block in some other method's invocation.
begin
  p [1, 2, 3].map(&:double)
# This will throw an error, because `&:double` converts the symbole `:double` to a Proc by looking for `double` as a method. It is the same as...
  Proc.new { |element| element.double}
# The error is thrown because the elements that we pass in are Intergers, and there is no `Integer#double` method.
rescue => e
  puts e.message
end

# The key difference between `.map(&double)` and `.map(&:double)` is:
# - `&double` takes a Proc object represented by the variable `double`, then converts it into a block to be passed to `map`, and effectively calls `double(element)` on each element of `map`'s caller: specifically it passes elements as arguments to the `double` method that is found in the lookup path at wherever `map` is invoked.
# - `&:double`, by contrast, calls `Symbol#to_proc` on the symbol `:double`, and the Proc that passed to `map` becomes `element.double`, making each element the caller rather than an argument, and making Ruby look for the method `double` under each element (i.e. caller)'s class, rather than making Ruby look for a method `double` found lexically where `map` is invoked. 
