require 'json'

module TaskWarrior
  class Repository
    def initialize(input)
      @tasks = {}
      @projects = Hash.new{|hash, key| hash[key] = Array.new}
      @tags = Hash.new{|hash, key| hash[key] = Array.new}

      JSON.parse(input).each{|json|
        task = TaskWarrior::TaskMapper.map(json)
        @tasks[task.uuid] = task
        @projects[task.project] << task if task.project
#        task.tags.each{|tag| @tags[tag] << task}
      }

      # Replace the uuid of each dependency with the real task
      @tasks.each_value{|task| task.dependencies.map!{|uuid| @tasks[uuid]}}

      # Replace the project of each task with a Project object and add the task to it

      # Replace the tag of each task with a Tag object and add the task to it

      # Add child tasks to their parent, but keep them in the global index
      @tasks.each_value do |task|
        if task.parent
          parent = @tasks[task.parent]
          parent.children << task if parent
          task.parent = parent
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
      @projects.keys
    end

#    def tags
#      @tags.keys
#    end
  end
end