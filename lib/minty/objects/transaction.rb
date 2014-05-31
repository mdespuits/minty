require 'minty/objects/model'

module Minty
  module Objects
    class Transaction < Model

      def self.build(json)
        json.each_with_object({}) do |transaction, transactions|
          transactions.merge! transaction['id'] => self.new(transaction)
        end
      end

      attribute :id
      attribute :account
      attribute :bank, "fi"
      attribute :description, "merchant"
      attribute :category
      attribute :category_id, "categoryId"
      attribute :labels
      attribute :original_description, "omerchant"
      attribute :amount
      attribute :note

      DATE_FORMAT = '%b %d'

      def debit?
        !!json['isDebit']
      end

      def pending?
        !!json['isPending']
      end

      def edited?
        !!json['isEdited']
      end
      
      def split?
        !!json['isChild']
      end

      def new?
        id.nil?
      end

      def to_update
        if not split?
          params = {
            :cashTxnType => "on", :mtCheckNo => "", :price => "", :symbol => "",
            :note => note, :isInvestment => "false", :catId => category_id,
            :category => category, :merchant => description, :date => date,
            :amount => amount
          }

          params.merge! :task => "txnAdd", :txnId => ":0", :mtCashSplitPref => "2", :mtAccount => account_id,
            :mtType => "pending-other", :mtIsExpense => amount < 0 ? "true" : "false" if new?

          params.merge! :task => "txnEdit", :txnId => "#{id}:0", :mtCashSplit => "on", :mtAccount => "",
            :mtType => "cash" unless new?
        else
          params = {:task => "split", :data => "", :txnId => "#{parent_id}:0"}
          return params if siblings.empty?
          
        end

        # figure out tags
        params
      end

        
          
      def date
        Date.strptime(json["date"], DATE_FORMAT)
      end

    end
  end
end
