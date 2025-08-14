def select2(arr)
  counter = 0
  new_arr = []
  until counter == arr.size
    new_arr << arr[counter] if yield(arr[counter])
    counter += 1
  end
  new_arr
end

p [1, 2, 3, 4].select { |num| num.odd? }
p select2([1, 2, 3, 4]) { |num| num.odd? }

array = [1, 2, 3, 4, 5]

p select2(array) { |num| num.odd? } == [1, 3, 5]     # => [1, 3, 5]
p select2(array) { |num| puts num } == []     # => [], because "puts num" returns nil and evaluates to false
p select2(array) { |num| num + 1 } ==[1, 2, 3, 4, 5]       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true