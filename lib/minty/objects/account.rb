require 'minty/objects/model'

module Minty
  module Objects
    class Account < Model

      def self.build(json)
        json.each_with_object([]) do |account, list|
          list.concat [self.new(account)]
        end
      end

      attribute :id
      attribute :name
      attribute :value
      attribute :type, 'accountType'
      attribute :balance, 'currentBalance'

      def active?
        !!json['isActive']
      end

      def closed?
        !!json['isClosed']
      end

      def to_s
        "#<#{self.class.name} id=#{id} name=#{name} value=#{value} type=#{type}>"
      end
      alias inspect to_s

    end
  end
end
