require 'text-table'

require 'minty/utils'
require 'minty/cli/command'

module Minty
  class CLI
    class Accounts < Command
      banner "Usage: minty accounts [options]"

      option :exclude,
        short: "-e EXCLUDE",
        long: "--exclude EXCLUDE",
        default: "vehicle",
        required: false,
        description: "Which account types to exclude (e.g. 'credit,bank')"

      option :require,
        short: "-r REQUIRE",
        long: "--require REQUIRE",
        default: "",
        required: false,
        description: "Which account types to include (e.g. 'vehicle,bank')"

      option :sort_by,
        short: "-s SORT",
        long: "--sort-by SORT",
        default: :value,
        required: false,
        description: "Which column to sort by"

      option :reverse,
        long: "--reverse",
        default: false,
        required: false,
        description: "Reverse sort order"

      def exec
        table = Text::Table.new
        table.head = %w[Name Value Type]
        accounts do |account|
          table.rows << [account.name, Utils.dollars(account.value), account.type.capitalize]
        end
        puts table
      end

      private

        def accounts(&blk)
          result = client.accounts
                    .reject { |a| excluded_account_types.include? a.type }
                    .sort_by { |a| a.send(sort_column) }
          result = result.reverse if reverse?
          result.each(&blk)
        end

        def reverse?
          config[:reverse]
        end

        def sort_column
          config[:sort_by].downcase
        end

        def excluded_account_types
          excluded = config[:exclude].downcase.split(",")
          included = config[:require].downcase.split(",")
          excluded - included
        end
    end
  end
end
