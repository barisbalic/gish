module Gish
  module Commands
    module Comment
      def update_comment(comment_number, comment)
        request( Proc.new{ client.update_comment(Gish.repository, comment_number, comment) })
      end

      def delete_comment(comment_number)
        request( Proc.new{ client.delete_comment(Gish.repository, comment_number) })
      end

      def issue_comment(comment_number)
        request( Proc.new{ client.issue_comment(Gish.repository, comment_number) })
      end

      private

      def request(proc)
        begin
          proc.call
        rescue Octokit::NotFound
          puts "Could not find the specified comment."
          exit 1
        rescue Octokit::Unauthorized
          puts "Something is wrong with your personal access token."
          exit 1
        end
      end

    end
  end
end