module Gish
  module Commands
    module Comment
      def update_comment(comment_number, comment)
        request { client.update_comment(Gish.repository, comment_number, comment) }
      end

      def delete_comment(comment_number)
        request { client.delete_comment(Gish.repository, comment_number) }
      end

      def issue_comment(comment_number)
        request { client.issue_comment(Gish.repository, comment_number) }
      end
    end
  end
end