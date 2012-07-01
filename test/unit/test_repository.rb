require 'test_helper'

class TestRepository < Test::Unit::TestCase
  include TaskWarrior::Test::Fixtures
  
  def setup
    @repo = TaskWarrior::Repository.new(File.read(fixture('party_taxes.json')))
  end
  
  def test_all
    assert_equal(7, @repo.tasks.size, 'Should not present recurring tasks as separate tasks') 
  end  
end
