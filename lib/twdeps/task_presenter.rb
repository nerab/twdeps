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
        }

        if :completed == task.status
          self.attributes.merge!({:fontcolor => 'gray', :color => 'gray'})
        end
      end
    end
  end
end