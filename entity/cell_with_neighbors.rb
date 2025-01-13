class CellWithNeighbors < Cell
  attr_reader :neighbor_bomb_cell_count

  def initialize(bomb:, neighbors: [])
    super(bomb:)
    @neighbors = neighbors
    @neighbor_bomb_cell_count = count_neighbor_bomb_cell
  end

  def neighbors
    @neighbors.dup
  end

  def add_neighbor(neighbor:)
    @neighbors << neighbor
    @neighbor_bomb_cell_count += 1 if neighbor.bomb?
  end

  def count_revealed_cell
    neighbors.count(&:revealed?)
  end

  def reveal_with_neighbors
    # NOTE: 再帰処理の終了条件
    return if revealed?

    reveal

    # NOTE: 選択したセルが爆弾の場合は再帰処理を終了
    return if bomb?

    if neighbor_bomb_cell_count.zero?
      neighbors.each(&:reveal_with_neighbors)
    end
  end

  private

  def count_neighbor_bomb_cell
    neighbors.count(&:bomb?)
  end
end
