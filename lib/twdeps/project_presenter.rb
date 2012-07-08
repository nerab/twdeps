module TaskWarrior
  module Dependencies
    #
    # Presents a project's attributes suitable for a GraphViz cluster
    #
    class ProjectPresenter < Presenter
      def initialize(project)
        self.attributes = {:label => project.name}
        self.id = "cluster_#{project.name}"
      end
    end
  end
end