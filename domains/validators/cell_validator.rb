module Domains
  module Validators
    class CellValidator < Base
      def validate_toggle_flag!
        errors.add("Cannot toggle_flag a revealed cell") if object.revealed?
        raise Error, errors.full_messages unless errors.empty?
      end

      def validate_reveal!
        errors.add("Cannot reveal a revealed cell") if object.revealed?
        raise Error, errors.full_messages unless errors.empty?
      end
    end
  end
end
