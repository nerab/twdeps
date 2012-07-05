module TaskWarrior
  module Dependencies
    #
    # Presents a task's attributes suitable for a GraphViz node
    #
    class TaskPresenter
      def initialize(task)
        @task = task
      end
      
      def attributes
        attrs = {:label => @task.description}
        attrs.merge!({:tooltip => "Status: #{@task.status}"})

        # TODO Once we see the urgency in the JSON export, we can color-code the nodes
        # http://taskwarrior.org/issues/973
        # attrs.merge!({:fillcolor => 'red', :style => 'filled'})

        attrs.merge!({:fontcolor => 'gray', :color => 'gray'}) if :completed == @task.status
        attrs
      end
      
      def id
        @task.uuid
      end
    end
  end
end