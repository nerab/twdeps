require 'test_helper'

module TaskWarrior
  module Test
    class TestBrokenDependencies < MiniTest::Test
      include TaskWarrior::Test::Fixtures

      def setup
        graph = TaskWarrior::Dependencies::Graph.new(self.class.name)

        TaskWarrior::Repository.new(File.read(fixture('dead-dependency.json'))).tasks.each do |task|
          graph << task
        end

        @parsed_graph = TaskWarrior::Test::PlainGraphParser.new(graph.render(:plain))
      end


      def test_node_size
        assert_equal(2, @parsed_graph.nodes.size)
      end

      def test_node_text
        refute_nil(@parsed_graph.node('2170fecc-0646-4320-99e0-75ed3c365f1c'))
      end
    end
  end
end
