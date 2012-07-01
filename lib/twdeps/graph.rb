module TaskWarrior
  module Dependencies
    # Builds a dependency graph
    # 
    # +thing+ is added as node with all of its dependencies. 
    # +thing.to_s+ is called for the label.
    # +thing.id+ is called for the identifier. It must be unique within thing and all of its dependencies.
    #
    # +resolver.dependencies(thing)+ is called to resolve dependencies of +thing+. If must return a list
    # of things. Each thing may have its own dependencies which will be resolved recursively.
    #
    # Design influenced by https://github.com/glejeune/Ruby-Graphviz/blob/852ee119e4e9850f682f0a0089285c36ee16280f/bin/gem2gv
    #
    class Graph
      class << self
        def formats
          Constants::FORMATS
        end
      end
      
      #
      # Build a new Graph for +thing+, using +resolver+ to find thing's dependencies.
      #
      # +thing+ may be nil, and it depends on the behavior of the resolver what happens.
      #
      def initialize(thing = nil, resolver = nil, presenter = TaskPresenter)
        @graphviz = GraphViz::new(:G)
        @dependencies = []
        @edges = []
        @resolver = resolver
        @presenter = presenter
        resolve(thing)
      end
      
      def render(format)
        @graphviz.output(format => nil)
      end
    
    private
      def resolve(thing = nil)
        if thing.nil?
          @resolver.dependencies.each{|t| resolve(t)}
        else
          dependencies = @resolver.dependencies(thing)
          create_edges(thing, dependencies)
        
          # resolve all dependencies we don't know yet
          dependencies.each do |dependency|
            unless @dependencies.include?(dependency)
              @dependencies << dependency
              resolve(dependency)
            end
          end
        end
      end
  
      def create_edges(thing, nodes)
        nodeA = find_or_create_node(thing)
    
        nodes.each do |node|
          nodeB = find_or_create_node(node)
          create_edge(nodeA, nodeB)
        end
      end
      
      def find_or_create_node(thing)
        @graphviz.get_node(thing.id) || create_node(thing)
      end
      
      def create_node(thing)
        @graphviz.add_nodes(thing.id, @presenter.new(thing).attributes)
      end

      def create_edge(nodeA, nodeB)
        edge = [nodeA, nodeB]
        unless @edges.include?(edge)
          @edges << edge
          @graphviz.add_edges(nodeA, nodeB)
        end
      end
    end
  end
end
