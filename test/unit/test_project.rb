require 'test_helper'

class TestProject < Test::Unit::TestCase
  include TaskWarrior::Test::Validations
  
  def test_name
    project = TaskWarrior::Project.new('foo')
    assert_valid(project)
    assert_empty(project.tasks)
  end
  
  def test_empty_tasks
    project = TaskWarrior::Project.new('foo', [])
    assert_valid(project)
    assert_empty(project.tasks)
  end
  
  def test_with_tasks
    project = TaskWarrior::Project.new('foo', [TaskWarrior::Task.new('foobar')])
    assert_valid(project)
    assert_equal(1, project.tasks.size)
  end

  def test_name_nil
    project = TaskWarrior::Project.new(nil)
    assert_invalid(project)
  end

  def test_name_empty
    project = TaskWarrior::Project.new('')
    assert_invalid(project)
  end

  def test_name_with_space
    project = TaskWarrior::Project.new('foo bar')
    assert_invalid(project)
  end

  def test_name_just_space
    project = TaskWarrior::Project.new(' ')
    assert_invalid(project)
  end
end
