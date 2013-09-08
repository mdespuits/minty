require 'mixlib/cli'
require 'text-table'

module Minty
  class CLI
    class Accounts
      include Mixlib::CLI

      def initialize(*args)
        @credentials = Minty::Credentials.load
        @client      = Minty::Client.new(@credentials)
        super
      end

      def exec
        table = Text::Table.new
        table.head = %w[Name Value Type]
        @client.accounts.sort_by { |a| -a.value }.each do |account|
          table.rows << [account.name, account.value, account.type.capitalize]
        end
        puts table
      end
    end
  end
end
