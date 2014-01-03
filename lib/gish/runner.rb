require 'thor'

require_relative 'cli/labels'
require_relative 'cli/comments'

module Gish
  class Runner < Thor
    no_tasks do
      include InputHelpers
    end

    class_option :repository, :type=> :string , :aliases => '-r', :desc => 'Specify the repository.'
    def initialize(*args)
      super
      return unless options.repository? && options.repository != 'repository'
      Gish.repository = options.repository
    end

    desc 'labels SUBCOMMAND ...ARGS', 'Manage labels for the repository.'
    subcommand 'labels', Gish::Cli::Labels

    desc 'label ISSUE_NUMBER LABEL [LABEL]...', 'Add one or more labels to an issue.'
    def label(issue_number, label, *more_labels)
      Gish.label(issue_number, label, more_labels)
    end

    desc 'unlabel ISSUE_NUMBER LABEL [LABEL]...', 'Remove a label from an issue.'
    def unlabel(issue_number, label, *more_labels)
      Gish.unlabel(issue_number, label, more_labels)
    end

    desc 'comments SUBCOMMAND ...ARGS', 'Manage comments for an issue.'
    subcommand 'comments', Gish::Cli::Comments

    desc 'comment ISSUE_NUMBER', 'Comment on an issue.'
    method_option :message, :type => :string, :aliases => '-m', :desc => 'Specify the message inline.'
    def comment(issue_number)
      message = capture_editor_input unless options.message? || options.message == 'message'
      message ||= options.message
      Gish.comment(issue_number, message)
    end

    desc 'list [COUNT]', 'List issues.'
    method_option :closed, :type => :boolean, :aliases => '-c', :desc => 'Show closed issues.'
    method_option :order, :type => :string, :aliases => '-o', :desc => 'Ordering by asc or desc.'
    def list(count=20)
      args = {:per_page => count}
      args[:state] = 'closed' if options.closed?
      args[:direction] = 'asc' if options.order == 'asc'
      puts Gish.list(args)
    end

    desc 'show ISSUE_NUMBER', 'Display the issue in full.'
    method_option :include_comments, :type => :boolean, :aliases => '-i', :desc => 'Include comments.'
    def show(issue_number)
      puts Gish.show(issue_number)
      puts "\n"
      puts Gish.comments(issue_number) if options.include_comments?
    end

    desc 'close ISSUE_NUMBER', 'Close an issue.'
    method_option :force, :type => :boolean, :aliases => '-f', :desc => 'Force yes, no prompt!'
    method_option :message, :type => :string, :aliases => '-m', :desc => 'Provide a message before closing.'
    def close(issue_number)
      return unless options.force? || options.message? || confirm("Are you sure you want to close issue ##{issue_number} (y/n)... ")
      message = capture_editor_input if options.message? && options.message == 'message'
      message ||= options.message
      Gish.comment(issue_number, message) if options.message?
      Gish.close(issue_number)
    end

    desc 'reopen ISSUE_NUMBER', 'Reopen a closed issue.'
    def reopen(issue_number)
      Gish.reopen(issue_number)
    end

    desc 'browse [ISSUE_NUMBER]', 'View issues in your browser.'
    def browse(issue_number=nil)
      Gish.browse(issue_number)
    end

    desc 'assignees', 'List assignees for the repository.'
    def assignees
      puts Gish.list_assignees
    end

    desc 'assign ISSUE_NUMBER USER_LOGIN', 'Assign an issue to a user.'
    def assign(issue_number, user_login)
      Gish.assign(issue_number, user_login)
    end

    desc 'unassign ISSUE_NUMBER', 'Unassign an issue.'
    def unassign(issue_number)
      Gish.unassign(issue_number)
    end

    desc 'open TITLE', 'Open a new issue.'
    method_option :labels, :type => :array, :aliases => '-l', :desc => 'Add labels.'
    method_option :assignee, :type => :string, :aliases => '-a', :desc => 'Assign someone to the issue.'
    method_option :message, :type => :string, :aliases => '-m', :desc => 'Specify the message inline.'
    def open(title)
      labels = (options.labels || []).map{|l| l.strip }
      message = capture_editor_input unless options.message? && options.message != 'message'
      message ||= options.message
      assignee = options.assignee
      Gish.create(title, message, labels, assignee)
    end

    desc 'edit ISSUE_NUMBER', 'Edit an issue.'
    method_option :title, :type => :string, :aliases => '-t', :desc => 'Specify the new title'
    def edit(issue_number)
      issue = Gish.show(issue_number)
      message = capture_editor_input(issue.body)
      title = options.title unless options.nil? and options.title.nil?
      title ||= issue.title
      Gish.edit(issue_number, title, message)
    end

    desc 'version', 'Display the version of Gish.'
    def version
      puts "v#{Gish::VERSION}"
    end
  end
end
