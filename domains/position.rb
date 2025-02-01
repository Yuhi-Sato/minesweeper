module Domains
  class Position < Base
    attr_reader :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    with_validation :initialize
  end
end
