# dogs = ['fido', 'max']
some_proc = Proc.new { p dogs }

# -- lots of code omitted

dogs = 'airbud'
some_proc.call
