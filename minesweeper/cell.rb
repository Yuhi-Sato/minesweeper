class Cell
  attr_accessor :neighbor_bomb_cell_count

  def initialize(bomb:)
    @bomb = bomb
    @flag = false
    @revealed = false
  end

  def bomb?
    @bomb
  end

  def flag?
    @flag
  end

  def toggle_flag
    @flag = !@flag
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
  end
end

class CellFactory
  def initialize(num_cells:, num_bombs:, width:, neighbor:)
    @num_cells = num_cells
    @num_bombs = num_bombs
    @width = width
    @height = num_cells / width
    @neighbor = neighbor
  end

  def create_grid_cells
    cells = Array.new(@num_bombs) { Cell.new(bomb: true) } +
            Array.new(@num_cells - @num_bombs) {  Cell.new(bomb: false) }

    grid_cells = cells.shuffle.each_slice(@width).to_a

    grid_cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbor_bomb_cell_count = @neighbor.coordinations(x:, y:).count do |nx, ny|
          grid_cells[ny][nx].bomb?
        end
      end
    end

    grid_cells
  end
end
