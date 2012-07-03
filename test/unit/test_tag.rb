require 'test_helper'

class TestTag < Test::Unit::TestCase
  include TaskWarrior
  include TaskWarrior::Test::Validations

  def test_name
    tag = Tag.new('foo')
    assert_valid(tag)
    assert_empty(tag.tasks)
  end

  def test_empty_tasks
    tag = Tag.new('foo', [])
    assert_valid(tag)
    assert_empty(tag.tasks)
  end

  def test_with_tasks
    tag = Tag.new('foo', [Task.new('foobar')])
    assert_valid(tag)
    assert_equal(1, tag.tasks.size)
  end

  def test_name_nil
    tag = Tag.new(nil)
    assert_invalid(tag)
  end

  def test_name_empty
    tag = Tag.new('')
    assert_invalid(tag)
  end

  def test_name_with_space
    tag = Tag.new('foo bar')
    assert_invalid(tag)
  end

  def test_name_just_space
    tag = Tag.new(' ')
    assert_invalid(tag)
  end

  def test_construction
    foo = Tag.new('foo')
    assert_equal(foo, Tag.new(foo))
    assert_equal(Tag.new(foo), foo)
  end

  def test_value_object
    f1 = Tag.new('foo')
    f2 = Tag.new('foo')
    assert_not_equal(f1.object_id, f2.object_id)
    assert_equal(f1, f2)
  end
end
