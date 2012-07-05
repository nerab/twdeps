module TaskWarrior
  module Dependencies
    class NullPresenter
      def attributes
        {:label => 'Unknown', :fontcolor => 'red'}
      end

      def id
        'null'
      end
    end

    # Builds a dependency graph
    #
    # +thing+ is added as node with all of its dependencies. A presenter is used to present the task as node label.
    # +thing.id.to_s+ is called for the identifier. It must be unique within the graph and all of its dependencies.
    #
    # +thing.dependencies(thing)+ is called if +thing+ responds to it. It is expected to return a list
    # of things the thing depends on. Each thing may have its own dependencies which will be resolved recursively.
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
      # Build a new Graph for +thing+
      # # TODO Accept a presenter that would default to GlobalPresenter with {:rankdir => 'BT'}
      def initialize(name = :G, attributes = [])
        @graph = GraphViz::new(name, attributes)
        @dependencies = []
        @edges = []
      end

      def <<(task_or_project)
        if task_or_project.respond_to?(:dependencies)
          task = task_or_project
          nodeA = find_or_create_node(task)
          create_edges(nodeA, task.dependencies)

          # resolve all dependencies we don't know yet
          task.dependencies.each do |dependency|
            unless @dependencies.include?(dependency)
              @dependencies << dependency
              self << dependency
            end
          end
        else
          # it's a project
          project = task_or_project
          cluster = Graph.new(presenter(project).id, presenter(project).attributes)

          project.tasks.each do |task|
            cluster << task
          end

          # add all nodes and edges from cluster as a subgraph to @graph
          @graph.add_graph(cluster.graph)
        end
      end

      def render(format)
        @graph.output(format => String)
      end

    protected
      attr_reader :graph

    private
      def create_edges(nodeA, nodes)
        nodes.each do |node|
          nodeB = find_or_create_node(node)
          create_edge(nodeA, nodeB)
        end
      end

      def find_or_create_node(thing)
        @graph.get_node(presenter(thing).id) || create_node(thing)
      end

      def create_node(thing)
        @graph.add_nodes(presenter(thing).id, presenter(thing).attributes)
      end

      def create_edge(nodeA, nodeB)
        edge = [nodeA, nodeB]
        unless @edges.include?(edge) # GraphViz lacks get_edge, so we need to track existing edges ourselfes
          @edges << edge
          @graph.add_edges(nodeA, nodeB)
        end
      end

      def presenter(thing)
        # TODO Will counter-caching the presenters improve performance?
        if thing.nil?
          NullPresenter.new
        else
          if thing.respond_to?(:dependencies)
            TaskPresenter.new(thing)
          else
            ProjectPresenter.new(thing)
          end
        end
      end
    end
  end
end
