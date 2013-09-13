require 'text-table'

require 'minty/cli/command'

module Minty
  class CLI
    class Transactions < Command
      banner "Usage: minty accounts [options]"

      option :count,
        :short => "-c COUNT",
        :long => "--count COUNT",
        :default => 20,
        :description => "Number of transactions to display"

      def exec
        table = Text::Table.new
        table.head = %w[Description Amount Category Account Date]

        client.transactions.take(config[:count].to_i).each do |t|
          table.rows << [
            t.description,
            t.amount,
            t.category,
            t.account,
            t.date
          ]
        end
        puts table
      end
    end
  end
end
