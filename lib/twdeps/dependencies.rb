module TaskWarrior
  module Dependencies
    class Dependency < Struct.new(:name)
      def to_s
        name
      end
    end
    
    # 
    # Refactored version of https://github.com/glejeune/Ruby-Graphviz/blob/852ee119e4e9850f682f0a0089285c36ee16280f/bin/gem2gv
    #
    class Scanner
      def initialize(gemName)
        @graph = GraphViz::new(:G)
        @dependencies = []
        resolve(Dependency.new(gemName))
      end
      
      # TODO should be passed an IO object to write to
      def render(format = 'dot')
        @graph.output(format => nil)
      end
    
    private
      def resolve(dependency)
        dependencies = retrieveDependencies(dependency)    
        create_edges(dependency, dependencies)
        
        # resolve all dependencies we don't know yet
        dependencies.each do |dependency|
          unless @dependencies.include?(dependency)
            @dependencies << dependency
            resolve(dependency)
          end
        end
      end
      
      #
      # Returns a list of things that +thing+ depends on
      #
      def retrieveDependencies(thing)
        dependencies = []
    
        fetcher = Gem::SpecFetcher.fetcher
    
        fetcher.find_matching(Gem::Dependency.new(thing.name, '>0')).each do |spec_tuple, source_uri|
          fetcher.fetch_spec(spec_tuple, URI.parse(source_uri)).dependencies.each do |dep|
            dependency = Dependency.new(dep.name)
            dependencies << dependency unless dependencies.include?(dependency)
          end
        end

        return dependencies
      end
  
      def create_edges(thing, nodes)
        nodeA = find_or_create_node(thing)
    
        nodes.each do |node|
          nodeB = find_or_create_node(node)
          @graph.add_edges(nodeA, nodeB)
        end
      end
      
      def find_or_create_node(thing)
        return @graph.get_node(thing.hash.to_s) || @graph.add_nodes(thing.hash.to_s, "label" => thing.to_s)
      end
    end
  end
end
