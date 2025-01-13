class Board
  attr_reader :grid_cells, :with, :height, :num_cells, :num_bombs, :num_empties, :neighbor, :grid_cells

  def initialize(width:, height:, num_bombs:)
    @width = width
    @height = height
    @num_cells = width * height
    @num_bombs = num_bombs
    @num_empties = num_cells - num_bombs
    @neighbor = NeighborCoordination.new(width:, height:)
    @grid_cells = CellFactory.new(num_cells:, num_bombs:, width:, neighbor:).create_grid_cells
  end

  def reveal_cell(x:, y:)
    cell = grid_cells[y][x]

    # NOTE: 再帰処理の終了条件
    return if cell.revealed?

    cell.reveal

    # NOTE: 選択したセルが爆弾の場合はそのまま返す
    return if cell.bomb?

    # NOTE: 近傍に爆弾がない場合は再帰的にセルを開く
    if cell.neighbor_bomb_cell_count.zero?
      neighbor.coordinations(x:, y:).each do |nx, ny|
        reveal_cell(x: nx, y: ny)
      end
    end
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
end
