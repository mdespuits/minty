module Minty
  module Objects
    class Account
      def initialize(account_hash)
        @hash = account_hash
      end

      def to_h
        @hash.dup
      end

      def [](value)
        @hash[value]
      end

      def id
        @hash['id']
      end

      def name
        @hash['name']
      end

      def value
        @hash['value']
      end

      def balance
        @hash['currentBalance']
      end

      def type
        @hash['accountType']
      end

      def active?
        !!@hash['isActive']
      end

      def closed?
        !!@hash['isClosed']
      end

      def to_s
        "#<#{self.class.name} id=#{id} name=#{name} value=#{value} type=#{type}>"
      end
      alias inspect to_s

    end
  end
end
