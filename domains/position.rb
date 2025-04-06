# frozen_string_literal: true
# rbs_inline: enabled

module Domains
  # @rbs inherits Base
  class Position < Base
    # @rbs @x: Integer
    # @rbs @y: Integer

    attr_reader :x, :y #: Integer

    # @rbs (x: Integer, y: Integer) -> void
    def initialize(x:, y:)
      @x = x
      @y = y
    end

    # @rbs!
    #   extend Base::ClassMethods
    with_validation :initialize
  end
end
