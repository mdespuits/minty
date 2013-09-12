require 'io/console'

require 'minty/cli/command'

module Minty
  class CLI
    class Login < Command

      banner "Usage: minty login [options]"

      option :email,
        :short => "-e EMAIL",
        :long => "--email EMAIL",
        :description => "Mint.com email"

      option :password,
        :short => "-p PASSWORD",
        :long => "--password PASSWORD",
        :description => "Mint.com password"

      option :clear,
        :long => "--clear",
        :description => "Reset Minty credentials"

      def exec
        if config[:clear]
          Minty::Credentials.clear! if config[:clear]
          puts "Your Mint.com credentials have been cleared."
          return
        end

        credentials = Minty::Credentials.load

        if config[:email] && config[:password]
          credentials.email = config[:email]
          credentials.password = config[:password]
          puts "Minty credentials saved."
          return credentials.save
        end

        if credentials.setup?
          puts "You are already logged in, #{credentials.email}."
        else
          if config[:email]
            credentials.email = config[:email]
          else
            print "You Mint Email: "
            credentials.email = $stdin.gets.chomp
          end

          if config[:password]
            credentials.password = config[:password]
          else
            print "You Mint Password: "
            credentials.password = STDIN.noecho(&:gets)
            print "\n"
          end

          credentials.save

          puts "Your Mint.com credentials have been saved."
        end
      end
    end
  end
end
