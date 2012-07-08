module TaskWarrior
  module Dependencies
    class NullPresenter < Presenter
      def initialize
        self.id = 'null'
        self.attributes = {:label => 'Unknown', :fontcolor => 'red'}
      end
    end
   end
 end
 