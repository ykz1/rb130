def reduce2(array, start=nil)
  if start == nil
    accumulator = array[0]
    counter = 1
  else
    accumulator = start
    counter = 0
  end
  until counter == array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end
  accumulator
end

array = [1, 2, 3, 4, 5]

p reduce2(array) { |acc, num| acc + num } == 15
p reduce2(array, 10) { |acc, num| acc + num }  == 25
begin
  reduce2(array) { |acc, num| acc + num if num.odd? }
rescue => e
  puts e.message
end

p reduce2(['a', 'b', 'c']) { |acc, value| acc += value } == 'abc'
p reduce2([[1, 2], ['a', 'b']]) { |acc, value| acc + value } == [1, 2, 'a', 'b']