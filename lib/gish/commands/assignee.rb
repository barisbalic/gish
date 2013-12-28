module Gish
  module Commands
    module Assignee
      def list_assignees
        assignees = request('assignee') { client.repository_assignees(Gish.repository) }
        assignees.map{|a| a.login }
      end
    end
  end
end