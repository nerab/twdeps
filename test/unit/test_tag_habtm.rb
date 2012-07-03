require 'test_helper'

class TestTagHasAndBelongsToMany < Test::Unit::TestCase
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

    assert_tagged_with(@lookup_foo, @foo)
    assert_tagged_with(@lookup_foo, @metasyntactic)
    assert_not_tagged_with(@lookup_foo, @deadbeef)

    assert_not_tagged_with(@lookup_deadbeef, @foo)
    assert_tagged_with(@lookup_deadbeef, @metasyntactic)
    assert_tagged_with(@lookup_deadbeef, @deadbeef)
  end

  def test_tag_has_tasks
    assert_equal(1, @foo.tasks.size)
    assert_equal(1, @deadbeef.tasks.size)
    assert_equal(2, @metasyntactic.tasks.size)

    assert_contains_task(@deadbeef, @lookup_deadbeef)
    assert_not_contains_task(@deadbeef, @lookup_foo)
    assert_not_contains_task(@foo, @lookup_deadbeef)
    assert_contains_task(@foo, @lookup_foo)

    assert_contains_task(@metasyntactic, @lookup_deadbeef)
    assert_contains_task(@metasyntactic, @lookup_foo)
  end

  def assert_tagged_with(task, tag)
    assert(task.tags.include?(tag), "#{task} expected to be tagged with #{tag}, but it isn't.'")
  end

  def assert_not_tagged_with(task, tag)
    assert(!task.tags.include?(tag), "#{task} expected not to be tagged with #{tag}, but it actually is.")
  end

  def assert_contains_task(tag, task)
    assert(tag.tasks.include?(task), "#{tag} expected to contain #{task}, but it doesn't.")
  end

  def assert_not_contains_task(tag, task)
    assert(!tag.tasks.include?(task), "#{tag} expected to not contain #{task}, but it actually does.")
  end
end
