require 'test_helper'

class TestTag < Test::Unit::TestCase
  include TaskWarrior::Test::Validations

  def test_name
    tag = TaskWarrior::Tag.new('foo')
    assert_valid(tag)
    assert_empty(tag.tasks)
  end

  def test_empty_tasks
    tag = TaskWarrior::Tag.new('foo', [])
    assert_valid(tag)
    assert_empty(tag.tasks)
  end

  def test_with_tasks
    tag = TaskWarrior::Tag.new('foo', [TaskWarrior::Task.new('foobar')])
    assert_valid(tag)
    assert_equal(1, tag.tasks.size)
  end

  def test_name_nil
    tag = TaskWarrior::Tag.new(nil)
    assert_invalid(tag)
  end

  def test_name_empty
    tag = TaskWarrior::Tag.new('')
    assert_invalid(tag)
  end

  def test_name_with_space
    tag = TaskWarrior::Tag.new('foo bar')
    assert_invalid(tag)
  end

  def test_name_just_space
    tag = TaskWarrior::Tag.new(' ')
    assert_invalid(tag)
  end
end
