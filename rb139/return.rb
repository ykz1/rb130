def method_with_lambda(lambda_obj)
  lambda_obj.call
  puts "hello after lambda"
end

some_lambda = lambda do
  puts "hello from lambda"
  return
end

method_with_lambda(some_lambda)


def method_with_proc(proc_obj)
  proc_obj.call
  puts "hello after proc"
end

some_proc = Proc.new do
  puts "hello from Proc"
  return
end

method_with_proc(some_proc)