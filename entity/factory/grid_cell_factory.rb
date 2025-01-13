class GridCellFactory
  NUM_NEIGHBORS = 8
  DX = [0, 1, 1, 1, 0, -1, -1, -1]
  DY = [-1, -1, 0, 1, 1, 1, 0, -1]

  def initialize(width:, height:, num_bombs:)
    @width = width
    @height = height
    @num_cells = width * height
    @num_bombs = num_bombs
  end

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

  private

  def coordinations(x:, y:)
    NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
      .select { |nx, ny| nx.between?(0, @width - 1) && ny.between?(0, @height - 1) }
  end
end
