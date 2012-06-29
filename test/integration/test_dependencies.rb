require 'test_helper'

class DependencyTest < TaskWarrior::Test::Integration::TestCase
  def test_no_dependencies
    exec("import #{fixture('no_deps.json')}")
    tasks = export_tasks
    assert_equal(6, tasks.size)
  end
  
  def test_full_dependencies
    exec("import #{fixture('party.json')}")
    tasks = export_tasks
    assert_equal(6, tasks.size)
  end
end