require 'active_model'

module TaskWarrior
  class Project
    attr_reader :name, :tasks

    include ActiveModel::Validations
    validates :name, :presence => true
    validate :name_may_not_contain_spaces

    def initialize(name, tasks = [])
      @name = name
      @tasks = tasks
      @tasks.each{|t| t.project = self}
    end

    def <<(task)
      @tasks << task
      task.project = self
    end

    def to_s
      "Project #{name} (#{@tasks.size} tasks)"
    end

    private
    def name_may_not_contain_spaces
      if !name.blank? and name[/\s/]
        errors.add(:name, "may not contain spaces")
      end
    end
  end
end
