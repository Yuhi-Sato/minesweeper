class GridCellsCreator
  NUM_NEIGHBORS = 8
  DX = [0, 1, 1, 1, 0, -1, -1, -1]
  DY = [-1, -1, 0, 1, 1, 1, 0, -1]

  WIDTH = 9
  HEIGHT = 9
  NUM_BOMBS = 10
  NUM_CELLS = WIDTH * HEIGHT

  def self.create
    cells = Array.new(NUM_BOMBS) { CellWithNeighbors.new(base: Cell.new(bomb: true)) } +
            Array.new(NUM_CELLS - NUM_BOMBS) { CellWithNeighbors.new(base: Cell.new(bomb: false)) }

    data = cells.shuffle.each_slice(WIDTH).to_a
    data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        coordinations(x:, y:).each do |nx, ny|
          cell.add_neighbor(neighbor: data[ny][nx])
        end
      end
    end

    GridCells.new(data:)
  end

  private

  def self.coordinations(x:, y:)
    NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
      .select { |nx, ny| nx.between?(0, WIDTH - 1) && ny.between?(0, HEIGHT - 1) }
  end
end
