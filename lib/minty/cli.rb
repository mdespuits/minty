require 'mixlib/cli'

require 'minty'

require 'minty/cli/default'
require 'minty/cli/login'
require 'minty/cli/accounts'
require 'minty/cli/refresh'
require 'minty/cli/goals'

module Minty
  class CLI
    include Mixlib::CLI

    option :email,
      :short => "-e EMAIL",
      :long => "--email EMAIL",
      :description => "Your Mint.com email address"

    option :password,
      :short => "-p PASSWORD",
      :long => "--password PASSWORD",
      :description => "Your Mint.com password"

    def self.factory(name)
      class_name = name.to_s.strip.capitalize
      klass = class_name.empty? ? Minty::CLI::Default : Minty::CLI.const_get(class_name)
    rescue NameError => e
      puts "-> Sorry, no command '#{name}'\n\n"
      Minty::CLI::Default
    end

  end
end
