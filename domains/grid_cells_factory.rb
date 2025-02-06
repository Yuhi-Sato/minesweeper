# frozen_string_literal: true

module Domains
  module GridCellsFactory
    NUM_NEIGHBORS = 8
    DX = [0, 1, 1, 1, 0, -1, -1, -1].freeze
    DY = [-1, -1, 0, 1, 1, 1, 0, -1].freeze

    class << self
      def create(difficulty)
        case difficulty
        when Domains::Minesweeper::EASY
          random_create(width: 5, height: 5, num_bombs: 3)
        when Domains::Minesweeper::NORMAL
          random_create(width: 9, height: 9, num_bombs: 10)
        when Domains::Minesweeper::HARD
          random_create(width: 16, height: 16, num_bombs: 40)
        else
          raise ArgumentError, "unknown difficulty: #{difficulty}"
        end
      end

      private

      def random_create(width:, height:, num_bombs:)
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

      def coordinations(x:, y:, width:, height:)
        NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
                     .select { |nx, ny| nx.between?(0, width - 1) && ny.between?(0, height - 1) }
      end
    end
  end
end
