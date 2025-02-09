# frozen_string_literal: true

require_relative 'validators/base'
require_relative 'validators/cell_validator'
require_relative 'validators/grid_cells_validator'
require_relative 'validators/position_validator'

require_relative 'base'
require_relative 'cell_with_neighbors'
require_relative 'cell'
require_relative 'grid_cells_factory'
require_relative 'grid_cells'
require_relative 'position'

module Domains
  class Minesweeper < Base
    attr_reader :grid_cells

    EASY = :easy
    NORMAL = :normal
    HARD = :hard

    def initialize(difficulty)
      @grid_cells = GridCellsFactory.create(difficulty)
      @finished = false
    end

    def reveal_cell(x, y)
      grid_cells.reveal_cell(position: Position.new(x:, y:))
      check_finish_after_reveal
    end

    def toggle_flag(x, y)
      grid_cells.toggle_flag(position: Position.new(x:, y:))
    end

    def finished?
      @finished
    end

    private

    def check_finish_after_reveal
      @finished = grid_cells.bombed? || grid_cells.num_empties == grid_cells.count_revealed_cell
    end
  end
end
