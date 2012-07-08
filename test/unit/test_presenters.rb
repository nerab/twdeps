require 'test_helper'

module TaskWarrior
  module Test
    class TestPresenters < ::Test::Unit::TestCase
      include TaskWarrior::Dependencies
      include TaskWarrior::Test::Fixtures

      def setup
        @repo = TaskWarrior::Repository.new(File.read(fixture('party_taxes.json')))
      end
    
      def test_string_presentation
        foo = 'foo'
        p = Presenter.new(foo)
        assert_equal(foo, p.id)
        assert_not_nil(p.attributes)
        assert_empty(p.attributes)
      end
    
      def test_null_presentation
        p = NullPresenter.new
        assert_equal('null', p.id)
        assert_equal({:label => 'Unknown', :fontcolor => 'red'}, p.attributes)
      end
    
      def test_project_presentation
        p = ProjectPresenter.new(@repo.project('party'))
        assert_equal('cluster_party', p.id)
        assert_equal({:label => 'party'}, p.attributes)
      end
    
      def test_task_presentation
        uuid = '67aafe0b-ddd7-482b-9cfa-ac42c43e7559'
        p = TaskPresenter.new(@repo[uuid])
        assert_equal(uuid, p.id)
        assert_equal({:label => 'Get cash from ATM', :tooltip => 'Status: pending'}, p.attributes)
      end
    end
  end
end
