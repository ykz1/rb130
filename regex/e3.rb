def mystery_math(str)
  str.gsub(/[+\-*\/]/,'?')
end

p mystery_math('4 + 3 - 5 = 2')
# '4 ? 3 - 5 = 2'

p mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# '(4 ? 3 + 2) / 7 - 1 = 1'