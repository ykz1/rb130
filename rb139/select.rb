def my_select(arr, &block)
  arr.each_with_object([]) { |element, output| output << element if block.call(element) }
end

p my_select([1, 2, 3]) { |element| element.odd? } # => [1, 3]


def my_select2(arr)
  arr.each_with_object([]) { |element, output| output << element if yield(element) }
end

p my_select2([1, 2, 3]) { |element| element.odd? } # => [1, 3]