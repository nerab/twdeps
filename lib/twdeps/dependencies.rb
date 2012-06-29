module TaskWarrior
  module Dependencies
    class Dependency < Struct.new(:name, :version)
    end
    
    # 
    # Refactored version of https://github.com/glejeune/Ruby-Graphviz/blob/852ee119e4e9850f682f0a0089285c36ee16280f/bin/gem2gv
    #
    class Scanner
      def initialize(gemName, version = ">0")
        @graph = GraphViz::new(:G)
        @dependencies = []
        resolve(Dependency.new(gemName, version))
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

      def retrieveDependencies(dependency)
        dependencies = []
    
        gem_dependency = Gem::Dependency.new(dependency.name, dependency.version)
        fetcher = Gem::SpecFetcher.fetcher
    
        fetcher.find_matching(gem_dependency).each do |spec_tuple, source_uri|
          spec = fetcher.fetch_spec spec_tuple, URI.parse(source_uri)
      
          spec.dependencies.each do |dep|
            dependency = Dependency.new(dep.name, '>0')
            dependencies << dependency unless dependencies.include?(dependency)
          end
        end

        return dependencies
      end
  
      def create_edges(dependency, nodes)
        nodeA = find_or_create_node(dependency.name, dependency.version)
    
        nodes.each do |node|
          nodeB = find_or_create_node(node.name, node.version)
          @graph.add_edges(nodeA, nodeB)
        end
      end
      
      def find_or_create_node(name, version)
        return @graph.get_node(name) || @graph.add_nodes(name, "label" => "#{name} #{version}")
      end
    end
  end
end
