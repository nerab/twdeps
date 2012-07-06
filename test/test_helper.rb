require 'twtest'
require 'twdeps'
require 'helpers/plain_graph_parser.rb'

module TaskWarrior
  module Test
    module Fixtures
      def fixture(name)
        File.join(File.dirname(__FILE__), 'fixtures', name)
      end
    end
    
    module Validations
      def assert_valid(task)
        assert(task.valid?, error_message(task.errors))
      end

      def assert_invalid(task)
        assert(task.invalid?, 'Expect validation to fail')
      end

      def error_message(errors)
        errors.each_with_object([]){|e, result|
          result << e.join(' ')
        }.join("\n")
      end
    end
  end
end