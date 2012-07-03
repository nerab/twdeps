require 'forwardable'

module TaskWarrior
  class ValidationError < StandardError;end

  # TODO Potentially obsolete
  class Tags
    extend Forwardable
    def_delegators :@tags, :each, :size, :include?

    def initialize
      @tags = []
    end

    def <<(tag)
      raise ValidationError.new('Tag must not be nil') if tag.nil?
      raise ValidationError.new(tag.errors.full_messages) if tag.invalid?

      @tags << tag
    end

    def [](name)
      return nil if name.nil?
      @tags.find{|tag| tag.name == name}
    end

    def all
      @tags.values.dup
    end
  end
end
