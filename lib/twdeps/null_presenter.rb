module TaskWarrior
  module Dependencies
    class NullPresenter < Presenter
      def initialize
        super('null')
        self.attributes = {:label => 'Unknown', :fontcolor => 'red'}
      end
    end
  end
end

