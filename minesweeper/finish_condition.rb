class FinishCondition
  attr_reader :board

  def initialize(board:)
    @board = board
  end

  def check_after_reveal
    board.bombed? || board.num_empties == board.count_revealed_cell
  end
end
