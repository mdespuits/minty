require 'text-table'

require 'minty/cli/command'

module Minty
  class CLI
    class Goals < Command
      banner "Usage: minty budget [options]"

      def exec
        table = Text::Table.new
        table.head = %w[Name Amount Budget Status]

        client.goals.each do |goal|
          table.rows << [
            goal.name,
            goal.amount,
            goal.budget,
            goal.status.capitalize
          ]
        end
        puts table
      end
    end
  end
end
