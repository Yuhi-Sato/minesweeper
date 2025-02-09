# frozen_string_literal: true

module Domains
  class GridCells < Base
    attr_reader :num_empties

    def initialize(cells:)
      @cells = cells
      @num_empties = count_empty_cell
    end

    def reveal_cell(position:)
      @cells[position.y][position.x].reveal_with_neighbors
    end

    def toggle_flag(position:)
      @cells[position.y][position.x].toggle_flag
    end

    def count_revealed_cell
      @cells.flatten.count(&:revealed?)
    end

    def bombed?
      @cells.flatten.any? { |cell| cell.bomb? && cell.revealed? }
    end

    def width
      @cells.first.size
    end

    def height
      @cells.size
    end

    # TODO: 別クラスに実装する
    def display
      print '  '

      @cells.first.each_with_index do |_row, x|
        print "#{x} "
      end

      puts

      print '  '

      @cells.first.each do |_row, _x|
        print '--'
      end

      puts

      @cells.each_with_index do |row, y|
        print "#{y}|"

        row.each do |cell|
          if cell.revealed?
            if cell.bomb?
              print 'B '
            elsif cell.neighbor_bomb_cell_count.zero? || cell.count_revealed_cell == cell.neighbors.size
              print '◻︎ '
            else
              print "#{cell.neighbor_bomb_cell_count} "
            end
          elsif cell.flag?
            print 'F '
          else
            print '◼︎ '
          end
        end
        puts
      end
    end

    def to_a
      result = []

      @cells.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          result << {
            x:,
            y:,
            revealed: cell.revealed?,
            flagged: cell.flag?,
            bomb: cell.bomb?,
            neighbor_bomb_cell_count: cell.neighbor_bomb_cell_count,
            count_revealed_cell: cell.count_revealed_cell,
            neighbors_size: cell.neighbors.size
          }
        end
      end

      result
    end

    with_validation :reveal_cell, :toggle_flag

    private

    def count_empty_cell
      @cells.flatten.count(&:empty?)
    end
  end
end
