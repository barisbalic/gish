module Gish
  module Cli
    class Labels < Thor
      no_tasks do
        include InputHelpers
      end

      desc 'list', 'List all labels for this repository.'
      def list
        puts Gish.list_labels
      end

      desc 'create NAME [color]', 'Create a new label for this repository.'
      def create(name, color=nil)
        Gish.create_label(name, color)
      end

      desc 'update NAME [color]', 'Update an existing label.'
      def update(name, title, color=nil)
        Gish.update_label(name, title, color)
      end

      desc 'delete NAME', 'Delete an existing label.'
      method_option :force, :type => :boolean, :aliases => '-f', :desc => 'Force yes, no prompt!'
      def delete(name, *names)
        return unless options.force? || confirm('Are you sure you want to delete this label(s)? (y/n)... ')
        names << name
        Gish.delete_labels(names)
      end
    end
  end
end