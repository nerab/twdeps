require 'active_model'

module TaskWarrior
  class Tag
    attr_reader :name

    include ActiveModel::Validations
    validates :name, :presence => true
    validate :name_may_not_contain_spaces

    def initialize(tag_or_name, tasks = [])
      if tag_or_name.respond_to?(:name)
        @name = tag_or_name.name
        @tasks = tag_or_name.tasks
      else
        @name = tag_or_name
        @tasks = []
      end

      tasks.each{|task|
        self << task
      }
    end

    def <<(task)
      @tasks << task unless @tasks.include?(task)
#      task.tags << self unless task.tags.include?(self)
    end

    def tasks
      @tasks #.dup
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
