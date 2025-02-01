module Domains
  module Validators
    class PositionValidator < Base
      def validate_initialize!(x:, y:)
        errors.add("x must be an integer") unless x.is_a?(Integer)
        errors.add("y must be an integer") unless y.is_a?(Integer)
        raise Error, errors.full_messages unless errors.empty?
      end
    end
  end
end
