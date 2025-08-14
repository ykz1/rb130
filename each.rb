def each2(arr)
  counter = 0
  until counter == arr.size
    yield(arr[counter])
    counter += 1
  end
  arr
end

p [1, 2, 3].each { |num| "do nothing" }.select { |num| num.odd? }
p each2([1, 2, 3]) { |num| "do nothing" }.select { |num| num.odd? }