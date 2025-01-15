class Board
  attr_reader :num_empties, :grid_cells

  def initialize(num_cells:, num_bombs:, grid_cell_factory:)
    @num_cells = num_cells
    @num_bombs = num_bombs
    @num_empties = calculate_num_empties
    @grid_cells = grid_cell_factory.create_grid_cells
  end

  def reveal_cell(x:, y:)
    grid_cells[y][x].reveal_with_neighbors
  end

  def toggle_flag(x:, y:)
    grid_cells[y][x].toggle_flag
  end

  def count_revealed_cell
    grid_cells.flatten.count { |cell| cell.revealed? }
  end

  def bombed?
    grid_cells.flatten.any? { |cell| cell.bomb? && cell.revealed? }
  end

  private

  def calculate_num_empties
    @num_cells - @num_bombs
  end
end
