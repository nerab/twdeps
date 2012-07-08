module TaskWarrior
  module Dependencies
    #
    # Presents a thing to the graph
    #
    class Presenter
      def initialize(id)
        @id = id
        @attributes = {:label => id, :labelloc => 'top'}
      end

      def attributes
        @attributes
      end

      def id
        @id
      end

      protected
      attr_writer :id, :attributes
    end
   end
 end
 