p [1, 2, 3].map(&:to_s) # => ["1", "2", "3"]
p [1, 2, 3].map { |element| element.to_s } # => also ["1", "2", "3"]


some_proc = Proc.new { |num| num.to_s }
p [1, 2, 3].map(&some_proc) # => ["1", "2", "3"]
p [1, 2, 3].map { |num| num.to_s }