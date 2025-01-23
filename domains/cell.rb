class Cell
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

  def revealed?
    @revealed
  end

  def toggle_flag
    @flag = !@flag
  end

  def reveal
    @revealed = true
  end
end
