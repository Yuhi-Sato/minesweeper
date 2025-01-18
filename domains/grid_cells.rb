# TODO: このクラスを抽象クラスとして、2次元と3次元の具象クラスに分割する
class GridCells
  attr_reader :data, :num_empties

  NUM_NEIGHBORS = 8
  DX = [0, 1, 1, 1, 0, -1, -1, -1]
  DY = [-1, -1, 0, 1, 1, 1, 0, -1]

  def initialize(width:, height:, num_bombs:)
    @width = width
    @height = height
    @num_cells = width * height
    @num_bombs = num_bombs
    @num_empties = @num_cells - @num_bombs
    @data = create_grid_cells
  end

  def reveal_with_neighbors(position:)
    data[position.y][position.x].reveal_with_neighbors
  end

  def toggle_flag(position:)
    data[position.y][position.x].toggle_flag
  end

  def count_revealed_cell
    data.flatten.count(&:revealed?)
  end

  def bombed?
    data.flatten.any? { |cell| cell.bomb? && cell.revealed? }
  end

  private

  # TODO: Builder Patternを実装する
  def create_grid_cells
    cells = Array.new(@num_bombs) { CellWithNeighbors.new(bomb: true) } +
            Array.new(@num_cells - @num_bombs) {  CellWithNeighbors.new(bomb: false) }

    grid_cells = cells.shuffle.each_slice(@width).to_a

    grid_cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        coordinations(x:, y:).each do |nx, ny|
          cell.add_neighbor(neighbor: grid_cells[ny][nx])
        end
      end
    end

    grid_cells
  end


  def coordinations(x:, y:)
    NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
      .select { |nx, ny| nx.between?(0, @width - 1) && ny.between?(0, @height - 1) }
  end
end
