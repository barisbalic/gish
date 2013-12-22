require 'octokit'

module Gish
  module Configuration
    include InputHelpers
    attr_accessor :editor, :access_token, :repository, :browser

    def self.extended(base)
      base.defaults
    end

    def editor=(editor)
      @editor = editor
    end

    def access_token=(access_token)
      @access_token = access_token
    end

    def repository=(repository)
      @repository = repository
    end

    def browser=(browser)
      @browser = browser
    end

    def github_url
      "http://github.com/#{@repository}"
    end

    def defaults
      @config_file = File.expand_path('~/.gish')
      self.editor = (ENV['GISH_EDITOR'] || ENV['EDITOR']) || 'vi'
      self.browser = (ENV['GISH_BROWSER'] || ENV['BROWSER']) || 'open'
      self.repository = default_repository
      self.access_token = retrieve_or_generate_token
    end

    private 

    def default_repository
      url = %x(git config --get remote.origin.url)
      url.match(/:(.*)\.git/)[1]
    end

    def retrieve_or_generate_token
      return File.read(@config_file) if File.exists?(@config_file)

      puts "(step 1 of 2) Gish needs your login details to create a personal use token.  This only happens once and your credentials will not be stored."
      username = prompt('Username: ')
      password = prompt('Password: ')

      puts "(step 2 of 2) Gish works with public repositories by default, but if you want to use it with We are about to create a token, but first you need to decide if you want to use Gish with private repositories, we need to know now!"
      private_access = confirm("Use with private repositories? (y/n) ")

      github = Octokit::Client.new(:login => username, :password => password)      
      options = {
        :note => 'Gish: Github Issues on the command-line.',
        :note_url => 'http://github.com/barisbalic/gish/'
      }
      options.merge!({:scopes => ['repo']}) if private_access
      authorization = github.create_authorization(options)

      File.open(@config_file, 'w+') { |file| file.write(authorization.token) }
    end
  end
end