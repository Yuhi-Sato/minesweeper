# frozen_string_literal: true

module Domains
  class Cell < Base
    def initialize(bomb:)
      @bomb = bomb
      @flag = false
      @revealed = false
    end

    def bomb?
      @bomb
    end

    def empty?
      !@bomb
    end

    def flag?
      @flag
    end

    def revealed?
      @revealed
    end

    def toggle_flag
      @flag = !@flag
    end

    def reveal
      @revealed = true
    end

    with_validation :toggle_flag, :reveal
  end
end
