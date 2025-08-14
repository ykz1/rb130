require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todo_vf'

class TodoTest < Minitest::Test

  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    # list size returns same as array todos size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    # list first returns same to do obj as first of todos array
    assert_equal(@todos.first, @list.first)
  end

  def test_last
    # list last returns same to do obj as last of todos array
    assert_equal(@todos.last, @list.last)
  end

  def test_shift
    # shift returns the same as first obj of todos array
    assert_equal(@todos.shift, @list.shift)
    # list after shift same as todos array after removing first element
    assert_equal(@todos, @list.to_a)
  end

  def test_pop
    # pop returns same as last element of todos array
    assert_equal(@todos.pop, @list.pop)
    # list after pop same as todos array after removing last element
    assert_equal(@todos, @list.to_a)
  end

  def test_done?
    # return false if not all are done
    array_done = @todos.all? { |todo| todo.done? }
    assert_equal(array_done, @list.done?)
    # return true if all are done
    @todos.each { |todo| todo.done! }
    array_done = @todos.all? { |todo| todo.done? }
    assert_equal(array_done, @list.done?)
    
  end

  def test_wrong_type_add
    # TypeError is raised when adding a non-Todo object
    assert_raises(TypeError) do
      @list.add('hello')
    end
    assert_raises(TypeError) do
      @list.add(123)
    end
  end

  def test_add
    # test that << actually adds something to list
    todo4 = Todo.new('Test #add')
    @list.add(todo4)
    assert_includes(@list.to_a, todo4)
    # test that add also does this
    todo5 = Todo.new('Test #<<')
    @list << todo5
    assert_includes(@list.to_a, todo5)
  end

  def test_item_at
    # should return the right element matching what todos array returns
    assert_equal(@todos[2], @list.item_at(2))
    assert_equal(@todos[0], @list.item_at(0))
    assert_equal(@todos[-1], @list.item_at(-1))
    # test should raise IndexError if out of index
    assert_raises(IndexError) { @list.item_at(-99) }
    assert_raises(IndexError) { @list.item_at(99) }
  end

  def test_mark_done_at
    # test that item marked done is actually done
    @list.mark_done_at(1)
    assert(@list.to_a[1].done?)
    # test that no other items are marked done
    refute(@list.to_a[0].done?)
    refute(@list.to_a[2].done?)
    # test should raise IndexError if out of index
    assert_raises(IndexError) { @list.mark_done_at(-99) }
    assert_raises(IndexError) { @list.mark_done_at(99) }
  end

  def test_mark_undone_at
    # set all todos to done
    @todo1.done!
    @todo2.done!
    @todo3.done!
    # test that item marked undone is actually done
    @list.mark_undone_at(1)
    refute(@list.to_a[1].done?)
    # test that no other items are marked done
    assert(@list.to_a[0].done?)
    assert(@list.to_a[2].done?)
    # test should raise IndexError if out of index
    assert_raises(IndexError) { @list.mark_undone_at(-99) }
    assert_raises(IndexError) { @list.mark_undone_at(99) }
  end

  def test_done!
    # test that all to dos are indeed done
    @list.done!
    assert(@list.to_a.all? { |todo| todo.done? })
  end

  def test_remove_at
    # test that the right element is removed
    # test that the remainin list is indeed missing the removed element but no others
    @list.remove_at(1)
    @todos.delete_at(1)
    assert_equal(@todos, @list.to_a)
    # Test that IndexError is returned if index provided is out of range
    assert_raises(IndexError) { @list.remove_at(99) }
    assert_raises(IndexError) { @list.remove_at(-99) }    
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_lines
    @todo2.done!
    output =<<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    # make sure that #each returns the original object
    assert_same(@list, @list.each{})
    # make sure that we actually iterate through todo objects in list
    @list.each { |todo| todo.done! }
    assert(@list.to_a.all? { |todo| todo.done? })
  end

  def test_select
    list_before = @list
    # test that returned object is a new TodoList object
    assert_instance_of(TodoList, @list.select {})
    # test that selection is correct
    @todo2.done!
    assert_equal(@todos.select { |todo| todo.done? }, @list.select { |todo| todo.done? }.to_a)
    # test that original list object is intact and unchanged
    assert_equal(list_before, @list)
    assert_same(list_before, @list)
  end


end