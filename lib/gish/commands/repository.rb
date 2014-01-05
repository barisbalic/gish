module Gish
  module Commands
    module Repository
      def is_collaborator?(login)
        request { client.collaborator?(Gish.repository, login) }
      end
    end
  end
end
