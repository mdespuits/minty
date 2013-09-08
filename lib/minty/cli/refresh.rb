module Minty
  class CLI
    class Refresh
      include Mixlib::CLI

      banner "Usage: minty refresh"

      def initialize(*args)
        super
      end

      def exec
        @credentials = Minty::Credentials.load
        @client      = Minty::Client.new(@credentials)
        @client.refresh
        puts "Refreshing..."
      end

    end
  end
end
