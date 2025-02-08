# frozen_string_literal: true

module Domains
  module GridCellsFactory
    class << self
      def create(difficulty)
        conditions = case difficulty
                     when Domains::Minesweeper::EASY
                       { width: 5, height: 5, num_bombs: 3 }
                     when Domains::Minesweeper::NORMAL
                       { width: 9, height: 9, num_bombs: 10 }
                     when Domains::Minesweeper::HARD
                       { width: 16, height: 16, num_bombs: 40 }
                     else
                       raise ArgumentError, "unknown difficulty: #{difficulty}"
                     end

        create_by_conditions(conditions)
      end

      private

      def create_by_conditions(conditions)
        num_cells = conditions[:width] * conditions[:height]
        num_empty_cells = num_cells - conditions[:num_bombs]

        cells = Array.new(conditions[:num_bombs]) { CellWithNeighbors.new(base: Cell.new(bomb: true)) } +
                Array.new(num_empty_cells) { CellWithNeighbors.new(base: Cell.new(bomb: false)) }

        grid_cells = cells.shuffle.each_slice(conditions[:width]).to_a
        grid_cells.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            coordinations(x: x, y: y, width: conditions[:width], height: conditions[:height]).each do |nx, ny|
              cell.add_neighbor(neighbor: grid_cells[ny][nx])
            end
          end
        end

        GridCells.new(cells: grid_cells)
      end

      def coordinations(x:, y:, width:, height:)
        num_neighbors = 8
        dx = [0, 1, 1, 1, 0, -1, -1, -1]
        dy = [-1, -1, 0, 1, 1, 1, 0, -1]

        num_neighbors.times.map { |i| [x + dx[i], y + dy[i]] }
                     .select { |nx, ny| nx.between?(0, width - 1) && ny.between?(0, height - 1) }
      end
    end
  end
end
