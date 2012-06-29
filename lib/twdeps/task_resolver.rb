module TaskWarrior
  #
  # Facade the task class to use the uuid as identifier within the graph
  #
  module TaskFacade
    def id
      uuid
    end
    
    # use the task description as label
    def to_s
      description
    end
  end
  
  module Dependencies
    class TaskResolver
      def initialize(input)
        @tasks = JSON.parse(input).each_with_object({}){|json, tasks|
          task = TaskWarrior::TaskMapper.map(json)
          task.extend TaskFacade
          tasks[task.uuid] = task
        }
      end
      
      def dependencies(task = nil)
        if task.nil?
          @tasks.values
        else
          task.dependencies.map{|uuid| @tasks[uuid]}
        end
      end
    end
  end
end