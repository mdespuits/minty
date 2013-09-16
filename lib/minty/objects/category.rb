# https://wwws.mint.com/app/getJsonData.xevent?task=categories

require 'minty/objects/model'

module Minty
  module Objects
    class Category < Model
      def self.build(json)
        json.each_with_object([]) do |category, list|
          cat = self.new(category)
          children = category['children']
          if children 
            children.each do |child|
              cat.children.push self.new(child) 
            end
          end
          list.concat [cat]
        end
      end

      attribute :id
      attribute :name, 'value'
      attribute :level1, 'isL1'
      attribute :standard, 'isStandard'

      def children
        @children ||= []
      end

      def is_level1?
        level1
      end

      def standard?
        standard
      end

      def to_s
        "#<#{self.class.name} id=#{id} name=\"#{name}\" children=#{children}>"
      end
      alias inspect to_s

    end
  end
end
