require 'json'

module TaskWarrior
  class Repository
    def initialize(input)
      @tasks = {}
      @projects = Hash.new{|hash, key| hash[key] = Project.new(key)}
      @tags = Hash.new{|hash, key| hash[key] = Tag.new(key)}

      JSON.parse(input).each{|json|
        task = TaskWarrior::TaskMapper.map(json)
        @tasks[task.uuid] = task
        @projects[task.project].tasks << task if task.project
        
        # we need to replace the string instead of just adding te
        task.tags.map!{|name|
          @tags[name] << task
        }
      }

      # Replace the uuid of each dependency with the real task
      @tasks.each_value{|task| task.dependencies.map!{|uuid| @tasks[uuid]}}

      # Replace the project property of each task with a proper Project object carrying a name and all of the project's tasks
      @tasks.each_value{|task| task.project = @projects[task.project] if task.project}
      
      # Done in Tag#<<(task)
      # Replace all tag names in each task with the proper Tag object

      # Add child tasks to their parent, but keep them in the global index
      @tasks.each_value do |task|
        if task.parent
          parent = @tasks[task.parent]

          if parent # we know the parent
            parent.children << task
            task.parent = parent
          end
        end
      end
    end

    def tasks
      # Do not expose child tasks directly
      @tasks.values.reject{|t| t.parent}
    end

    # direct lookup by uuid
    def [](uuid)
      @tasks[uuid]
    end

    def projects
      @projects.values
    end

    def project(name)
      @projects[name] if @projects.has_key?(name)
    end

    def tags
      @tags.values
    end

    def tag(name)
      @tags[name] if @tags.has_key?(name)
    end
  end
end
