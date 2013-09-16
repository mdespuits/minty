require 'text-table'

require 'minty/utils'
require 'minty/cli/command'

module Minty
  class CLI
    class Categories < Command
      banner "Usage: minty categories [options]"

      def exec
        table = Text::Table.new
        table.head = ['Root ID', 'ID', 'Name', 'Standard']
        client.categories.sort_by { |a| a.name }.each do |category|
          table.rows << [category.id, nil, category.name, nil]
          category.children.each do |child|
            table.rows << [nil, child.id, child.name, child.standard?]
          end
        end
        puts table
      end
    end
  end
end
