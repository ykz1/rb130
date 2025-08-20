def my_method
  a = 10
  [1, 2, 3].each do |num|
    a = num
  end
  puts a
end

my_method