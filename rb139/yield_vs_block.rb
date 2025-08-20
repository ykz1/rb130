def process(data)
  return "no block given" unless block_given?
  yield(data.upcase)
end

# `yield` will yield to the implicit block passed to a method's invocation. By contrast, `&block` converts the block passed to a Proc object (that's what the `&` does) and saves it to the variable `block`. Here is the same method re-written to take an explicity block:

def process2(data, &proc_obj)
  return "no block given" if proc_obj.nil?
  proc_obj.call(data.upcase)
end

p process("block")
p process("block") { |arg| arg }

p process2("block")
p process2("block") { |arg| arg }

# The main benefit of saving the block argument explicitly to a Proc object is the ability to then pass that Proc object around to another method invocation. In the example below, the block passed to `process3`'s invocation is converted to a Proc object and assigned to variable `proc_obj`, we then pass that Proc object to `process2` as a block with `&proc_obj`.

def process3(data, &proc_obj)
  return "no block given" if proc_obj.nil?
  process2("block passed as argument", &proc_obj)
end

p process3("block")
p process3("block") { |arg| arg }