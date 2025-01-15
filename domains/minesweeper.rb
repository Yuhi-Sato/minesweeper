class Minesweeper
  attr_reader :board

  def initialize(width:, height:, num_bombs:)
    @width = width
    @height = height
    @num_bombs = num_bombs
    @board = Board.new(num_cells:, num_bombs:,
            grid_cell_factory: GridCellFactory.new(width:, height:, num_bombs:))
    @finished = false
  end

  def reveal_cell(x, y)
    board.reveal_cell(x: x, y: y)
    check_finish_after_reveal
  end

  def toggle_flag(x, y)
    board.toggle_flag(x: x, y: y)
  end

  def finished?
    @finished
  end

  private

  def num_cells
    @width * @height
  end

  def check_finish_after_reveal
    @finished = board.bombed? || board.num_empties == board.count_revealed_cell
  end
end
