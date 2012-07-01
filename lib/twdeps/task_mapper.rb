module TaskWarrior
  #
  # A DataMapper that makes new Tasks from a JSON representation
  #
  class TaskMapper
    class << self
      def map(json)
        Task.new(json['description']).tap{|t|
          t.id = json['id'].to_i
          t.uuid = json['uuid']
          t.entry = DateTime.parse(json['entry'])
          t.status = json['status'].to_sym
          t.project = json['project']
          
          if json['depends']
            if json['depends'].respond_to?(:split)
              t.dependencies = json['depends'].split(',') 
            else
              t.dependencies = json['depends']
            end
          end

          t.parent = json['parent'] # Children will be cross-indexed in the repository
          t.priority = PriorityMapper.map(json['priority'])
        }
      end
    end
  end
end