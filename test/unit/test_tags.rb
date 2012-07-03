require 'test_helper'

class TestTags < Test::Unit::TestCase
  include TaskWarrior
  include TaskWarrior::Test::Validations
=begin
  def setup
    @tags = Tags.new
  end

  def test_initial_size
    assert_equal(0, @tags.size)
  end

  def test_name_string
    foo = 'foo'
    @tags << foo
    assert_equal(1, @tags.size)
    assert_equal(foo, @tags[foo].name)

    # make sure we can access it by Tag, too
    assert_equal(foo, @tags[Tag.new(foo)].name)
  end

  def test_name_nil
    assert_raise(ValidationError){
      @tags << nil
    }
  end

  def test_name_empty
    assert_raise(ValidationError){
      @tags << ''
    }
  end

  def test_name_with_space
    assert_raise(ValidationError){
      @tags << 'foo bar'
    }
  end

  def test_name_just_space
    assert_raise(ValidationError){
      @tags << ' '
    }
  end
=end
end
