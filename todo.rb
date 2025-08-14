class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end
  
  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title && description == otherTodo.description && done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError.new("TypeError: Can only add Todo objects") if todo.class != Todo
    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos[0]
  end

  def last
    @todos[-1]
  end

  def to_a
    @todos.clone
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def to_s
    output = ''
    output << "---- #{title} ----\n"
    @todos.each { |todo| output << "#{todo}\n"}
    output
  end
    
  def item_at(idx)
    @todos.fetch(idx) { |_| raise IndexError }
  end

  def mark_done_at(idx)
    todo = item_at(idx)
    todo.done!
  end

  def mark_undone_at(idx)
    todo = item_at(idx)
    todo.undone!
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    item_at(idx)
    @todos.delete_at(idx)
  end

  def each
    @todos.each { |todo| yield(todo) }
  end


end


# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----
puts '---- Adding to the list -----'

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list << todo3                 # adds todo3 to end of list, returns list

list.add(1) rescue puts $!                    # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

puts list

# ---- Interrogating the list -----
puts
puts '---- Interrogating the list -----'

# size
puts list.size                       # returns 3

# first
puts list.first                      # returns todo1, which is the first item in the list

# last
puts list.last                       # returns todo3, which is the last item in the list

#to_a
p list.to_a                      # returns an array of all items in the list

#done?
puts list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----
puts '---- Retrieving an item in the list ----'

# item_at
p list.item_at rescue puts $!                   # raises ArgumentError
p list.item_at(1)                 # returns 2nd item in list (zero based index)
p list.item_at(100) rescue puts $!             # raises IndexError

# ---- Marking items in the list -----
puts '---- Marking items in the list -----'

# mark_done_at
p list.mark_done_at rescue puts $!             # raises ArgumentError
p list.mark_done_at(1)            # marks the 2nd item as done
p list.mark_done_at(100) rescue puts $!          # raises IndexError

# mark_undone_at
p list.mark_undone_at rescue puts $!           # raises ArgumentError
p list.mark_undone_at(1)          # marks the 2nd item as not done,
p list.mark_undone_at(100) rescue puts $!        # raises IndexError

# done!
puts list.done!                      # marks all items as done

# ---- Deleting from the list -----
puts '---- Deleting from the list -----'

# shift
list.shift                      # removes and returns the first item in list

# pop
list.pop                        # removes and returns the last item in list

puts list

list.add(todo1)
list.add(todo3)

# remove_at
p list.remove_at rescue puts $!                 # raises ArgumentError
p list.remove_at(1)               # removes and returns the 2nd item
p list.remove_at(100) rescue puts $!            # raises IndexError

# ---- Outputting the list -----

# to_s
puts list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym



puts "=============== Each"

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end