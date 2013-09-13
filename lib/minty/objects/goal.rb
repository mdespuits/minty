require 'minty/objects/model'

module Minty
  module Objects
    class Goal < Model

      def self.build(json)
        data  = JSON.parse(json)['set'][0]['data']
        goals = (data["current"] + data["completed"])
        goals.each_with_object([]) { |goal, list|
          list.concat [new(goal)]
        }
      end

      attribute :status
      attribute :name
      attribute :amount, "targetAmt"
      attribute :budget, "budgetAmt"

      def complete?
        json["status"] == "completed"
      end

      def behind?
        json["status"] == "behind"
      end

    end
  end
end
