# frozen_string_literal: true
# rbs_inline: enabled

require 'forwardable'

module Domains
  module Validators
    class CellValidator < Base
      extend Forwardable

      # @rbs!
      #   def revealed?: () -> bool
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
