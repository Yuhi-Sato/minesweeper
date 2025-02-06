# frozen_string_literal: true

module Domains
  class GridCells < Base
    attr_reader :num_empties

    def initialize(data:)
      @data = data
      @num_empties = count_empty_cell
    end

    def reveal_with_neighbors(position:)
      @data[position.y][position.x].reveal_with_neighbors
    end

    def toggle_flag(position:)
      @data[position.y][position.x].toggle_flag
    end

    def count_revealed_cell
      @data.flatten.count(&:revealed?)
    end

    def bombed?
      @data.flatten.any? { |cell| cell.bomb? && cell.revealed? }
    end

    def width
      @data.first.size
    end

    def height
      @data.size
    end

    # TODO: 別クラスに実装する
    def display
      print '  '

      @data.first.each_with_index do |_row, x|
        print "#{x} "
      end

      puts

      print '  '

      @data.first.each do |_row, _x|
        print '--'
      end

      puts

      @data.each_with_index do |row, y|
        print "#{y}|"

        row.each do |cell|
          if cell.revealed?
            if cell.bomb?
              print 'B '
            elsif cell.neighbor_bomb_cell_count == 0 || cell.count_revealed_cell == cell.neighbors.size
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

    with_validation :reveal_with_neighbors, :toggle_flag

    private

    def count_empty_cell
      @data.flatten.count(&:empty?)
    end
  end
end
