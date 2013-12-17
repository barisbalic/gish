module Gish
  module Cli
    class Comments < Thor
      no_tasks do
        include InputHelpers
      end

      desc 'list ISSUE_NUMBER', 'List all comments for the issue.'
      def list(issue_number)
        puts Gish.issue_comments(issue_number)
      end
      
      desc 'update COMMENT_NUMBER', 'Update a comment.'
      method_option :message, :aliases => '-m', :type => :string, :desc => 'Specify the message inline.'
      def update(comment_number)
        existing_comment = Gish.issue_comment(comment_number).body
        message = capture_editor_input(existing_comment) unless options.message? && options.message != 'message'
        message ||= options.message
        Gish.update_comment(comment_number, message)
      end

      desc 'delete COMMENT_NUMBER', 'Delete a comment.'
      method_option :force, :type => :boolean, :aliases => '-f', :desc => 'Force yes, no prompt!'
      def delete(comment_number)
        return unless options.force? || confirm('Are you sure you want to delete this comment? (y/n)... ')
        Gish.delete_comment(comment_number)
      end
    end
  end
end