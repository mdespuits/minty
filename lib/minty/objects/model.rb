module Minty
  module Objects
    class Model

      def self.attribute(name, json_attr = nil)
        define_method(name) do
          json[(json_attr || name).to_s]
        end
      end

      attr_reader :json
      def initialize(json)
        @json = json
      end

      def [](value)
        json[value]
      end

      def to_h
        json.dup
      end

    end
  end
end
