module Domains
  class Minesweeper < Base
    attr_reader :board

    def initialize(difficulty)
      grid_cells_creator = get_grid_cells_creator(difficulty)
      @board = Board.new(grid_cells: grid_cells_creator.create)
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

    def get_grid_cells_creator(difficulty)
      case difficulty
      when :easy
        GridCellsCreators::Easy.new
      when :normal
        GridCellsCreators::Normal.new
      when :hard
        GridCellsCreators::Hard.new
      end
    end

    def check_finish_after_reveal
      @finished = board.bombed? || board.num_empties == board.count_revealed_cell
    end
  end
end
