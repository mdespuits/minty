require 'csv'

module Minty
  module Objects
    class Transaction

      def self.build(transaction_csv)
        transactions = []
        csv = CSV.parse(transaction_csv, { headers: :first_row }) do |row|
          transactions.concat [self.new(row)]
        end
        transactions
      end

      def initialize(row)
        @row = row
      end

      def account
        @row["Account Name"]
      end

      def description
        @row["Description"]
      end

      def category
        @row["Category"]
      end

      def labels
        @row["Labels"]
      end

      DATE_FORMAT = '%m/%d/%Y'

      def date
        Date.strptime(@row["Date"], DATE_FORMAT)
      end

      def original_description
        @row["Original Description"]
      end

      def amount
        @row["Amount"]
      end

      def transaction_type
        @row["Transaction Type"]
      end

    end
  end
end
