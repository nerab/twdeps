# require 'bundler'
# Bundler.require

require 'twtest'
require 'twdeps'

module TaskWarrior
  module Test
    module Fixtures
      def fixture(name)
        File.join(File.dirname(__FILE__), 'fixtures', name)
      end
    end
  end
end