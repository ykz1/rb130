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
    output = "---- #{title} ----"
    @todos.each { |todo| output << "\n#{todo}"}
    output.chomp
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
    self
  end

  def select
    output = TodoList.new(title)
    self.each do |todo|
      output << todo if yield(todo)
    end
    output
  end

  def find_by_title(string)
    each { |todo| return todo if todo.title == string }
    nil
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    find_by_title(string).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# p list.find_by_title("Buy milk") # => returns Todo object
# p list.find_by_title("Buy tomatoes") # => returns nil
# list.mark_done("Buy milk")
# puts list.all_done # => prints list with 1 done item
# puts list.all_not_done # => prints list with 2 undone items
# list.mark_all_done
# puts list # => prints list with 3 items all done
# list.mark_all_undone
# puts list # => prints list with 3 items all undone