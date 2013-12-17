module Gish
  module Commands
    module Issue
      def list(options)
        issues = request(Proc.new{ client.issues(Gish.repository, options) })
        issues.map {|i| Gish::Issue.new(i).headline }
      end

      def show(issue_number)
        issue = request( Proc.new{ client.issue(Gish.repository, issue_number) })
        Gish::Issue.new(issue) if issue
      end

      def reopen(issue_number)
        request( Proc.new{ client.reopen_issue(Gish.repository, issue_number) })
      end

      def create(title, body, labels=[], assignee)
        options = {:labels => labels}
        options.merge!({:assignee => assignee}) unless assignee.nil?
        request( Proc.new{ client.create_issue(Gish.repository, title, body, options) })
      end

      def close(issue_number, comment=nil)
        request( Proc.new{ client.close_issue(Gish.repository, issue_number)} )
      end

      def issue_comments(issue_number)
        comments = request(Proc.new{ client.issue_comments(Gish.repository, issue_number) })
        comments.map {|c| Gish::Comment.new(c) }
      end

      def comment(issue_number, comment)
        request( Proc.new{ client.add_comment(Gish.repository, issue_number, comment) })
      end

      def label(issue_number, label, labels=[])
        labels << label
        sanitized_labels = labels.map{|l| l.strip }
        request( Proc.new{ client.add_labels_to_an_issue(Gish.repository, issue_number, sanitized_labels) })
      end

      def unlabel(issue_number, label, labels=[])
        labels << label
        labels.each do |l|
          request( Proc.new{ client.remove_label(Gish.repository, issue_number, l.strip) })
        end
      end      

      def assign(issue_number, user_login)
        options = {:assignee => user_login}
        issue = request( Proc.new{ client.issue(Gish.repository, issue_number) })
        request( Proc.new{ client.update_issue(Gish.repository, issue_number, issue.title, issue.body, options) })
      end

      def unassign(issue_number)
        issue = request( Proc.new{ client.issue(Gish.repository, issue_number) })
        request( Proc.new{ client.update_issue(Gish.repository, issue_number, issue.title, issue.body, {:assignee => ''}) })
      end

      def browse(issue_number=nil)
        command = "#{Gish.browser} '#{Gish.github_url}/issues/#{issue_number}'"
        %x{#{command}}
      end

      private

      def request(proc)
        begin
          proc.call
        rescue Octokit::NotFound
          puts "Could not find the specified issue."
          exit 1
        rescue Octokit::Unauthorized
          puts "Something is wrong with your personal access token."
          exit 1
        end
      end
    end
  end
end