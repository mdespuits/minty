module Minty
  module Objects
    class Goal

      def self.build(json)
        data  = JSON.parse(json)['set'][0]['data']
        goals = (data["current"] + data["completed"])
        goals.each_with_object([]) { |goal, list|
          list.concat [new(goal)]
        }
      end

      def initialize(json_hash)
        @hash = json_hash
      end

      def status
        @hash["status"]
      end

      def name
        @hash["name"]
      end

      def amount
        @hash["targetAmt"]
      end

      def budget
        @hash["budgetAmt"]
      end

      def complete?
        @hash["status"] == "completed"
      end

      def behind?
        @hash["status"] == "behind"
      end

    end
  end
end
