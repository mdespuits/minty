require 'text-table'

require 'minty/utils'
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
            { value: Utils.dollars(goal.amount), align: :right },
            { value: Utils.dollars(goal.budget), align: :right },
            goal.status.capitalize
          ]
        end
        puts table
      end
    end
  end
end
