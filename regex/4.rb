a = "A grey cat
A blue caterpillar
The lazy dog
The white cat
A loud dog
--A loud dog
Go away dog
The ugly rat
The lazy, loud dog".split("\n").each do |line|
  p line.scan(/(\AA|The\b) [a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z] (dog|cat)\z/)
end