5.times { |num| puts num }

def times2(int)
  counter = 0
  until counter == int
    yield(counter)
    counter += 1
  end
  int
end

puts
times2(5) { |num| puts num }