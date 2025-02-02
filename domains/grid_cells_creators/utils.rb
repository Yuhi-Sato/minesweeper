module Domains
  module GridCellsCreators
    class Utils
      NUM_NEIGHBORS = 8
      DX = [0, 1, 1, 1, 0, -1, -1, -1]
      DY = [-1, -1, 0, 1, 1, 1, 0, -1]

      def self.random_create(width:, height:, num_bombs:)
        num_cells = width * height
        cells = Array.new(num_bombs) { CellWithNeighbors.new(base: Cell.new(bomb: true)) } +
                Array.new(num_cells - num_bombs) { CellWithNeighbors.new(base: Cell.new(bomb: false)) }

        data = cells.shuffle.each_slice(width).to_a
        data.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            coordinations(x:, y:, width:, height:).each do |nx, ny|
              cell.add_neighbor(neighbor: data[ny][nx])
            end
          end
        end

        GridCells.new(data:)
      end

      def self.coordinations(x:, y:, width:, height:)
        NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
          .select { |nx, ny| nx.between?(0, width - 1) && ny.between?(0, height - 1) }
      end
    end
  end
end
