# frozen_string_literal: true

module Domains
  module Validators
    class GridCellsValidator < Base
      def validate_reveal_with_neighbors!(position:)
        errors.add('Cannot reveal position out of range') if position.y.negative? || position.x.negative?
        errors.add('Cannot reveal position out of range') if position.y >= object.height || position.x >= object.width
        raise Error, errors.full_messages unless errors.empty?
      end

      def validate_toggle_flag!(position:)
        errors.add('Cannot reveal position out of range') if position.y.negative? || position.x.negative?
        errors.add('Cannot reveal position out of range') if position.y >= object.height || position.x >= object.width
        raise Error, errors.full_messages unless errors.empty?
      end
    end
  end
end
