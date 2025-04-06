# frozen_string_literal: true
# rbs_inline: enabled

module Domains
  # @rbs inherits Base
  class Cell < Base
    # @rbs @bomb: bool
    # @rbs @flag: bool
    # @rbs @revealed: bool

    # @rbs (bomb: bool) -> void
    def initialize(bomb:)
      @bomb = bomb
      @flag = false
      @revealed = false
    end

    # @rbs () -> bool
    def bomb?
      @bomb
    end

    # @rbs () -> bool
    def empty?
      !@bomb
    end

    # @rbs () -> bool
    def flag?
      @flag
    end

    # @rbs () -> bool
    def revealed?
      @revealed
    end

    # @rbs () -> void
    def toggle_flag
      @flag = !@flag
    end

    # @rbs () -> void
    def reveal
      @revealed = true
    end

    # @rbs!
    #   extend Base::ClassMethods
    with_validation :toggle_flag, :reveal
  end
end
