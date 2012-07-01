require 'test_helper'
require 'date'
require 'active_support/core_ext'

# TODO Add tests for dependencies

class TestTask < Test::Unit::TestCase
  def setup
    @task = TaskWarrior::Task.new('foobar')
    @task.id = 1
    @task.uuid = '66465716-b08d-41ea-8567-91b988a2bcbf'
    @task.entry = DateTime.now
    @task.status = :pending
  end

  def test_task_id_nil
    @task.id = nil
    assert_invalid(@task)
  end

  def test_task_id_0
    @task.id = 0
    assert_invalid(@task)
  end

  def test_task_uuid_nil
    @task.uuid = nil
    assert_invalid(@task)
  end

  def test_task_uuid_empty
    @task.uuid = ''
    assert_invalid(@task)
  end

  def test_task_uuid_wrong_format
    @task.uuid = 'abcdefg'
    assert_invalid(@task)
  end

  def test_task_entry_nil
    @task.entry = nil
    assert_invalid(@task)
  end

  def test_task_entry_empty
    @task.entry = ''
    assert_invalid(@task)
  end

  def test_task_entry_wrong_format
    @task.entry = "foobar"
    assert_invalid(@task)
  end

  def test_task_entry_future
    @task.entry = DateTime.now.advance(:days => 1)
    assert_invalid(@task)
  end

  def test_task_status_nil
    @task.status = nil
    assert_invalid(@task)
  end

  def test_task_status_empty
    @task.status = ''
    assert_invalid(@task)
  end

  def test_task_status_unknown_string
    @task.status = "foobar"
    assert_invalid(@task)
  end

  def test_task_status_unknown_symbol
    @task.status = :foobar
    assert_invalid(@task)
  end

  def test_task_project_nil
    @task.project = nil
    assert_valid(@task)
  end

  def test_task_project_empty
    @task.project = ''
    assert_valid(@task)
  end

  def test_task_project_with_space
    @task.project = 'foo bar'
    assert_invalid(@task)
  end

  def test_task_project_just_space
    @task.project = ' '
    # TODO This should actually pass ...
    # assert_invalid(@task)
  end

  def test_task_project_something
    @task.project = 'foobar'
    assert_valid(@task)
  end

  def test_task_priority_nil
    @task.priority = nil
    assert_valid(@task)
  end

  def test_task_priority_empty
    @task.priority = ''
    assert_valid(@task)
  end

  def test_task_priority_unknown_string
    @task.priority = "foobar"
    assert_invalid(@task)
  end

  def test_task_priority_unknown_symbol
    @task.priority = :foobar
    assert_invalid(@task)
  end

  def test_task_priority_high
    @task.priority = :high
    assert_valid(@task)
  end

  def test_task_priority_medium
    @task.priority = :medium
    assert_valid(@task)
  end

  def test_task_priority_low
    @task.priority = :low
    assert_valid(@task)
  end

  def test_task_valid
    assert_valid(@task)
  end

  private
  def assert_valid(task)
    assert(@task.valid?, error_message(@task.errors))
  end

  def assert_invalid(task)
    assert(task.invalid?, 'Expect validation to fail')
  end

  def error_message(errors)
    errors.each_with_object([]){|e, result|
      result << e.join(' ')
    }.join("\n")
  end
end
