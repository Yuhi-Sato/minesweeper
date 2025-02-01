module Domains
  module Validators
    class GridCellsValidator < Base
      def validate_reveal_with_neighbors!(position:)
        if position.y.negative? || position.x.negative?
          errors.add("Cannot reveal position out of range")
        end
        if position.y >= object.data.length || position.x >= object.data[position.y].length
          errors.add("Cannot reveal position out of range")
        end
        raise Error, errors.full_messages unless errors.empty?
      end

      def validate_toggle_flag!(position:)
        if position.y.negative? || position.x.negative?
          errors.add("Cannot reveal position out of range")
        end
        if position.y >= object.data.length || position.x >= object.data[position.y].length
          errors.add("Cannot reveal position out of range")
        end
        raise Error, errors.full_messages unless errors.empty?
      end
    end
  end
end
