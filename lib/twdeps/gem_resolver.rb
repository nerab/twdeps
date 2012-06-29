
# re-open String to fulfill the id requirement
class String
  def id
    hash.to_s
  end
end

module TaskWarrior
  module Dependencies
    class GemDepencencyResolver
      #
      # Returns a list of things that +thing+ depends on
      #
      def dependencies(gem_name)
        dependencies = []

        fetcher = Gem::SpecFetcher.fetcher

        fetcher.find_matching(Gem::Dependency.new(gem_name.to_s, '>0')).each do |spec_tuple, source_uri|
          fetcher.fetch_spec(spec_tuple, URI.parse(source_uri)).dependencies.each do |dep|
            dependencies << dep.name unless dependencies.include?(dep.name)
          end
        end

        return dependencies
      end
    end
  end
end