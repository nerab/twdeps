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
        attrs = {:label => @task.to_s}
        attrs.merge!({:tooltip => "Status: #{@task.status}"})
        attrs.merge!({:fontcolor => 'gray', :color => 'gray'}) if :completed == @task.status
        attrs
      end
    end
  end
end