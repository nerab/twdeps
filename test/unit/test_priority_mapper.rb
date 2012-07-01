require 'test_helper'

class TestPriorityMapper < Test::Unit::TestCase
  def test_nil
    assert_nil(TaskWarrior::PriorityMapper.map(nil))
  end
  
  def test_empty
    assert_nil(TaskWarrior::PriorityMapper.map(''))
  end
  
  def test_low
    assert_equal(:low, TaskWarrior::PriorityMapper.map('L'))
  end
  
  def test_medium
    assert_equal(:medium, TaskWarrior::PriorityMapper.map('M'))
  end
  
  def test_high
    assert_equal(:high, TaskWarrior::PriorityMapper.map('H'))
  end
  
  def test_unknown
    assert_nil(TaskWarrior::PriorityMapper.map('crap'))
  end
end