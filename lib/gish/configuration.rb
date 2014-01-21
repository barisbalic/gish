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
      self.access_token = retrieve_or_generate_token
      self.editor = (ENV['GISH_EDITOR'] || ENV['EDITOR']) || 'vi'
      self.browser = (ENV['GISH_BROWSER'] || ENV['BROWSER']) || 'open'
      self.repository = default_repository
    end

    private 

    def default_repository
      url = %x(git config --get remote.origin.url)
      url.match(/:(.*)\.git/)[1] rescue ''
    end

   def retrieve_or_generate_token
      return File.read(@config_file) if File.exists?(@config_file)

      puts 'First time using Gish? Sweet! Please go to https://github.com/settings/applications and create a "Personal Access Token" to continue'
      token = prompt('Token: ')

      File.open(@config_file, 'w+') { |file| file.write(token) }
    end

  end
end
