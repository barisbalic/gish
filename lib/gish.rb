require "gish/version"
require "gish/helpers/input_helpers"
require "gish/helpers/terminal_helpers"
require "gish/configuration"
require "gish/commands/issue"
require "gish/commands/comment"
require "gish/commands/label"
require "gish/commands/assignee"
require "gish/presentation/issue"
require "gish/presentation/label"
require "gish/presentation/comment"
require 'gish/runner'

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
end
