require 'test_helper'

class TestRepository < Test::Unit::TestCase
  include TaskWarrior::Test::Fixtures
  
  def setup
    @repo = TaskWarrior::Repository.new(File.read(fixture('party_taxes.json')))
  end
  
  def test_all
    assert_equal(7, @repo.tasks.size) 
    
    one = @repo['6fd0ba4a-ab67-49cd-ac69-64aa999aff8a']
    assert_equal('Select a free weekend in November', one.description)
#    assert_equal('H', one.priority)
    assert_equal('party', one.project)
    assert_equal(:pending, one.status)

#    assert_equal(1, one.annotations.size)    
#    assert_equal(DateTime.new('20120629T191534Z'), one.annotations.first.entry)
#    assert_equal('the 13th looks good', one.annotations.first.entry.description)
  end
  
  def test_child
    assert_equal(1, @repo['b587f364-c68e-4438-b4d6-f2af6ad62518'].children.size) 
  end
  
  def test_parent
    assert_equal(@repo['b587f364-c68e-4438-b4d6-f2af6ad62518'], @repo['99c9e1bb-ed75-4525-b05d-cf153a7ee1a1'].parent) 
  end
end
