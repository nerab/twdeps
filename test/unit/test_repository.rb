require 'test_helper'

class TestRepository < Test::Unit::TestCase
  include TaskWarrior::Test::Fixtures
  
  def setup
    @repo = TaskWarrior::Repository.new(File.read(fixture('party_taxes.json')))
  end
  
  def test_all
    assert_equal(7, @repo.tasks.size, 'Should not present recurring tasks as separate tasks') 
  end
  
  def test_child
    assert_equal(1, @repo['b587f364-c68e-4438-b4d6-f2af6ad62518'].children.size) 
  end
  
  def test_parent
    assert_equal(@repo['b587f364-c68e-4438-b4d6-f2af6ad62518'], @repo['99c9e1bb-ed75-4525-b05d-cf153a7ee1a1'].parent) 
  end
end
