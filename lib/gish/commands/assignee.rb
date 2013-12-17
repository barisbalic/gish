module Gish
  module Commands
    module Assignee
      def list_assignees
        assignees = request { client.repository_assignees(Gish.repository) }
        assignees.map{|a| a.login }
      end
    end
  end
end