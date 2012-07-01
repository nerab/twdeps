module TaskWarrior
  class PriorityMapper
    class << self
      def map(json)
        {'H' => :high, 'M' => :medium, 'L' => :low}[json]
      end
    end
  end
end