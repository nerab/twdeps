require 'active_model'

module TaskWarrior
  class Tag
    attr_reader :name, :tasks

    include ActiveModel::Validations
    validates :name, :presence => true
    validate :name_may_not_contain_spaces

    def initialize(name, tasks = [])
      @name = name
      @tasks = []

      tasks.each{|task|
        self << task
      }
    end

    def <<(task)
      @tasks << task
      task.tags << self
    end

    def to_s
      "Tag: #{name} (#{@tasks.size} tasks)"
    end

    def ==(other)
      name == other.name
    end

    private
    def name_may_not_contain_spaces
      if !name.blank? and name[/\s/]
        errors.add(:name, "may not contain spaces")
      end
    end
  end
end
