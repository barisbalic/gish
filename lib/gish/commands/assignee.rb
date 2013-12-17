module Gish
  module Commands
    module Assignee
      def list_assignees
        assignees = request( Proc.new{ client.repository_assignees(Gish.repository) })
        assignees.map{|a| a.login }
      end

      private 

      def request(proc)
        begin
          proc.call
        rescue Octokit::Unauthorized
          puts "Something is wrong with your personal access token."
          exit 1
        end
      end
    end
  end
end