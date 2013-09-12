require 'text-table'

require 'minty/cli/command'

module Minty
  class CLI
    class Accounts < Command
      banner "Usage: minty accounts [options]"

      def exec
        table = Text::Table.new
        table.head = %w[Name Value Type]
        client.accounts.sort_by { |a| -a.value }.each do |account|
          table.rows << [account.name, account.value, account.type.capitalize]
        end
        puts table
      end
    end
  end
end
