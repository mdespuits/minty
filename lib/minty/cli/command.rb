require 'mixlib/cli'

module Minty
  class CLI
    class Command
      include Mixlib::CLI

      attr_reader :credentials, :client

      def initialize(*args)
        @credentials = Minty::Credentials.load
        @client      = Minty::Client.new(@credentials)
        super
      end

    end
  end
end
