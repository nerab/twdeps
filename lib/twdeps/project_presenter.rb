module TaskWarrior
  module Dependencies
    #
    # Presents a project's attributes suitable for a GraphViz cluster
    #
    class ProjectPresenter
      def initialize(project)
        @project = project
      end
      
      def attributes
        {:label => @project.name}
      end
      
      def id
        "cluster_#{@project.name}"
      end
    end
  end
end