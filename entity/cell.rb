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
