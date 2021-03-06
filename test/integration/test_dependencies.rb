require 'test_helper'

class DependencyTest < TaskWarrior::Test::Integration::Test
  include TaskWarrior::Test::Fixtures

  def test_no_dependencies
    task("import #{fixture('no_deps.json')}")
    tasks = export_tasks
    assert_equal(6, tasks.size)
  end

  def test_full_dependencies
    task("import #{fixture('party.json')}")
    tasks = export_tasks
    assert_equal(6, tasks.size)
  end
end
