# frozen_string_literal: true
# rbs_inline: enabled

module Domains
  # @rbs inherits Base
  class Minesweeper < Base
    # @rbs @grid_cells: GridCells
    # @rbs @finished: bool

    attr_reader :grid_cells #: GridCells

    EASY = :easy #: Symbol
    NORMAL = :normal #: Symbol
    HARD = :hard #: Symbol

    # @rbs (Symbol) -> void
    def initialize(difficulty)
      @grid_cells = GridCellsFactory.create(difficulty)
      @finished = false
    end

    # @rbs (Integer, Integer) -> void
    def reveal_cell(x, y)
      grid_cells.reveal_cell(position: Position.new(x:, y:))
      check_finish_after_reveal
    end

    # @rbs (Integer, Integer) -> void
    def toggle_flag(x, y)
      grid_cells.toggle_flag(position: Position.new(x:, y:))
    end

    # @rbs () -> bool
    def finished?
      @finished
    end

    private

    # @rbs () -> void
    def check_finish_after_reveal
      @finished = grid_cells.bombed? || grid_cells.num_empties == grid_cells.count_revealed_cell
    end
  end
end
