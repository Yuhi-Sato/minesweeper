class Minesweeper
  attr_reader :board, :finish_condition

  def initialize(width:, height:, num_bombs:)
    @board = Board.new(width:, height:, num_bombs:)
    @finish_condition = FinishCondition.new(board: @board)
    @finished = false
  end

  def reveal_cell(x, y)
    board.reveal_cell(x: x, y: y)
    check_finish_after_reveal
    board.update_neighbor_revealed_cell_count
  end

  def toggle_flag(x, y)
    board.toggle_flag(x: x, y: y)
  end

  def finished?
    @finished
  end

  private

  def check_finish_after_reveal
    @finished = finish_condition.check_after_reveal
  end
end
