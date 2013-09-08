require 'mixlib/cli'
require 'text-table'

module Minty
  class CLI
    class Goals
      include Mixlib::CLI

      banner "Usage: minty budget [options]"

      def initialize(*args)
        @credentials = Minty::Credentials.load
        @client      = Minty::Client.new(@credentials)
        super
      end

      def exec
        table = Text::Table.new
        table.head = %w[Name Amount Budget Status]

        @client.goals.each do |status, goals|
          goals.each do |goal|
            table.rows << [
              goal.name,
              goal.amount,
              goal.budget,
              status.capitalize
            ]
          end
        end
        puts table
      end
    end
  end
end
