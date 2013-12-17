module Gish
  class Comment
    include TerminalHelpers

    def initialize(github_comment)
      @body = github_comment.body.gsub("\r\n", "\n")
      @user = github_comment.user.login
      @id = github_comment.id
      @created_at = github_comment.created_at
    end

    def to_s
      output = "\n#{@id} #{bold(@user)} commented on #{@created_at}"
      output << "\n\"#{@body}\"\n"
      output
    end
  end
end