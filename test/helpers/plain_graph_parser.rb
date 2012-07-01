require 'csv'

module TaskWarrior
  module Test
    class Entry
      def initialize(fields)
        @fields = fields
      end
      
      protected
      attr_reader :fields
    end
    
    class Graph < Entry; end
    class Stop < Entry; end
        
    class Node < Entry
      attr_reader :id
      
      def initialize(fields)
        @id = fields.shift
        super
      end
      
      def label
        fields[4]
      end
    end
    
    class Edge < Entry
      attr_reader :from, :to
      
      def initialize(fields)
        @from = fields.shift
        @to = fields.shift
      end
    end
    
    class PlainGraphParser
      def initialize(lines)
        @bucket = Hash.new{|hash, key| hash[key] = Array.new}
        
        lines.each_line{|line|
          CSV.parse(line, :quote_char => '"', :col_sep => ' ') do |fields|
            o = TaskWarrior::Test.const_get(fields.shift.capitalize).new(fields)
            @bucket[o.class] << o
          end
        }
      end
      
      def edges
        @bucket[Edge]
      end
      
      def nodes
        @bucket[Node]
      end
      
      def node(id)
        @bucket[Node].select{|node| id == node.id}.first
      end
      
      def edge(from, to)
        @bucket[Edge].select{|edge| from == edge.from && to == edge.to}.first
      end      
    end
  end
end