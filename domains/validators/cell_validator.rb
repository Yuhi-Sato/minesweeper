# frozen_string_literal: true

require 'forwardable'

module Domains
  module Validators
    class CellValidator < Base
      extend Forwardable
      def_delegators :@object, :revealed?

      def validate_toggle_flag!
        errors.add('Cannot toggle_flag a revealed cell') if revealed?
        raise Error, errors.full_messages unless errors.empty?
      end

      def validate_reveal!
        errors.add('Cannot reveal a revealed cell') if revealed?
        raise Error, errors.full_messages unless errors.empty?
      end
    end
  end
end
