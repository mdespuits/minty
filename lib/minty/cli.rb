require 'mixlib/cli'

require 'minty'

require 'minty/cli/default'
require 'minty/cli/login'
require 'minty/cli/accounts'
require 'minty/cli/categories'
require 'minty/cli/refresh'
require 'minty/cli/transactions'
require 'minty/cli/goals'

module Minty
  class CLI

    def self.factory(name)
      class_name = name.to_s.strip.capitalize
      klass = class_name.empty? ? Minty::CLI::Default : Minty::CLI.const_get(class_name)
    rescue NameError => e
      puts "-> Sorry, no command '#{name}'\n\n"
      Minty::CLI::Default
    end

  end
end
