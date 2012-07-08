module TaskWarrior
  module Dependencies
    #
    # Presents a task's attributes suitable for a GraphViz node
    #
    class TaskPresenter < Presenter
      def initialize(task)
        self.id = task.uuid
        self.attributes = {
          :label => task.description,
          :tooltip => "Status: #{task.status}"
          }.tap{|attrs|
            attrs.merge!({:fontcolor => 'gray', :color => 'gray'}) if :completed == task.status
          }
      end
    end
  end
end