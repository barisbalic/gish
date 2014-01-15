require_relative "gish/version"
require_relative "gish/helpers/input_helpers"
require_relative "gish/helpers/terminal_helpers"
require_relative "gish/helpers/date_helpers"
require_relative "gish/configuration"
require_relative "gish/commands/issue"
require_relative "gish/commands/comment"
require_relative "gish/commands/label"
require_relative "gish/commands/assignee"
require_relative "gish/commands/repository"
require_relative "gish/presentation/issue"
require_relative "gish/presentation/label"
require_relative "gish/presentation/comment"
require_relative 'gish/runner'

module Gish
  extend Configuration

  def self.client
    @github ||= Octokit::Client.new(:access_token => Gish.access_token)
  end

  def self.request(resource='issue/comment/label')
    begin
      yield()
    rescue Octokit::NotFound
      puts "Could not find #{resource}."
      exit 1
    rescue Octokit::Unauthorized
      puts "Something is wrong with your personal access token."
      exit 1
    end
  end

  extend Gish::Commands::Label
  extend Gish::Commands::Issue
  extend Gish::Commands::Comment
  extend Gish::Commands::Assignee
  extend Gish::Commands::Repository
end
