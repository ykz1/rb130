def url?(str)
  str.match?(/\Ahttps?:\/\/\S+\z/)
end

p url?('https://launchschool.com')     # -> true
p url?('http://example.com')           # -> true
p url?('https://example.com hello')    # -> false
p url?('   https://example.com')       # -> false
p url?('https://example')