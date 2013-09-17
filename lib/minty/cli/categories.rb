require 'text-table'

require 'minty/cli/command'

module Minty
  class CLI
    class Categories < Command
      banner "Usage: minty categories [options]"

      def exec
        table = Text::Table.new
        table.head = ['Top Level', 'Child Category', 'Standard']
        client.categories.sort_by { |a| a.name }.each do |category|
          table.rows << [category.name, nil, nil]
          category.children.each do |child|
            table.rows << [nil, child.name, child.standard? ? 'Yes' : 'No']
          end
        end
        puts table
      end
    end
  end
end
