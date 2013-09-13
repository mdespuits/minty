require 'csv'
require 'minty/objects/model'

module Minty
  module Objects
    class Transaction < Model

      def self.build(transaction_csv)
        transactions = []
        csv = CSV.parse(transaction_csv, { headers: :first_row }) do |row|
          transactions.concat [self.new(row)]
        end
        transactions
      end

      attribute :account, "Account Name"
      attribute :description, "Description"
      attribute :category, "Category"
      attribute :labels, "Labels"
      attribute :original_description, "Original Description"
      attribute :amount, "Amount"
      attribute :transaction_type, "Transaction Type"

      DATE_FORMAT = '%m/%d/%Y'

      def date
        Date.strptime(json["Date"], DATE_FORMAT)
      end

    end
  end
end
