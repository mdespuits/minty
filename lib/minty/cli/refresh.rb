require 'minty/cli/command'

module Minty
  class CLI
    class Refresh < Command
      banner "Usage: minty refresh"

      def exec
        client.refresh
        puts "Refreshing..."
      end

    end
  end
end
