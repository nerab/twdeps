require 'test_helper'

class DependencyBuilderTest < TaskWarrior::Test::Integration::TestCase
  def test_no_dependencies
    exec("import #{fixture('no_deps.json')}")
    assert_equal(6, tasks.size)
  end
end