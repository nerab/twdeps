require 'test_helper'

class TestTag < Test::Unit::TestCase
  include TaskWarrior::Test::Validations

  def setup
    @lookup_foo = TaskWarrior::Task.new('Lookup foo in Wikipedia')
    @lookup_deadbeef = TaskWarrior::Task.new('Lookup deadbeef in Wikipedia')

    @foo = TaskWarrior::Tag.new('foo')
    @deadbeef = TaskWarrior::Tag.new('foo')
    @metasyntactic = TaskWarrior::Tag.new('metasyntactic')

    @foo << @lookup_foo
    @deadbeef << @lookup_deadbeef
    @metasyntactic << @lookup_foo
    @metasyntactic << @lookup_deadbeef
  end

  def test_task_tagged
    assert_equal(2, @lookup_foo.tags.size)
    assert_equal(2, @lookup_deadbeef.tags.size)

    assert(@lookup_foo.tags.include?(@foo))
    assert(@lookup_foo.tags.include?(@metasyntactic))
    assert(!@lookup_foo.tags.include?(@deadbeef))

    assert(!@lookup_deadbeef.tags.include?(@foo))
    assert(@lookup_deadbeef.tags.include?(@metasyntactic))
    assert(@lookup_deadbeef.tags.include?(@deadbeef))
  end

  def test_tag_has_tasks
    assert_equal(1, @foo.tasks.size)
    assert_equal(1, @deadbeef.tasks.size)
    assert_equal(2, @metasyntactic.tasks.size)

    assert(@deadbeef.tasks.include?(@lookup_deadbeef))
    assert(!@deadbeef.tasks.include?(@lookup_foo))
    assert(!@foo.tasks.include?(@lookup_deadbeef))
    assert(@foo.tasks.include?(@lookup_foo))

    assert(@metasyntactic.tasks.include?(@lookup_deadbeef))
    assert(@metasyntactic.tasks.include?(@lookup_foo))
  end
end
