module Minty
  class CLI
    class Default
      include Mixlib::CLI

      banner <<-EOS
Usage: minty [subcommand] [options]

Available subcommands are:

  login:    Save your Mint.com credentials for other actions
  refresh:  Refresh your Mint.com accounts
  accounts: Display a table of your Mint.com accounts
  goals:    Display your Mint.com goals

For more options on each subcommand, try:

  minty [subcommand] --help
      EOS

      def exec
        parse_options
        puts opt_parser
      end
    end
  end
end
