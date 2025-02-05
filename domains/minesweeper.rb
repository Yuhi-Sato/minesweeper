module Domains
  class Minesweeper < Base
    attr_reader :board

    EASY = :easy
    NORMAL = :normal
    HARD = :hard

    def initialize(difficulty)
      @board = Board.new(difficulty)
      @finished = false
    end

    def reveal_cell(x, y)
      board.reveal_cell(position: Position.new(x:, y:))
      check_finish_after_reveal
    end

    def toggle_flag(x, y)
      board.toggle_flag(position: Position.new(x:, y:))
    end

    def finished?
      @finished
    end

    private

    def check_finish_after_reveal
      @finished = board.bombed? || board.num_empties == board.count_revealed_cell
    end
  end
end
