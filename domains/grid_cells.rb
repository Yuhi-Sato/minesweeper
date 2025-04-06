# frozen_string_literal: true
# rbs_inline: enabled
module Domains
  # @rbs inherits Base
  class GridCells < Base
    # @rbs @cells: Array[Array[CellWithNeighbors]]
    # @rbs @num_empties: Integer

    attr_reader :num_empties #: Integer

    # @rbs (cells: Array[Array[CellWithNeighbors]]) -> void
    def initialize(cells:)
      @cells = cells
      @num_empties = count_empty_cell
    end

    # @rbs (position: Position) -> void
    def reveal_cell(position:)
      @cells[position.y][position.x].reveal_with_neighbors
    end

    # @rbs (position: Position) -> void
    def toggle_flag(position:)
      @cells[position.y][position.x].toggle_flag
    end

    # @rbs () -> Integer
    def count_revealed_cell
      @cells.flatten.count(&:revealed?)
    end

    # @rbs () -> bool
    def bombed?
      @cells.flatten.any? { |cell| cell.bomb? && cell.revealed? }
    end

    # @rbs () -> Integer
    def width
      @cells.first.size
    end

    # @rbs () -> Integer
    def height
      @cells.size
    end

    # TODO: 別クラスに実装する
    # @rbs () -> void
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

    # @rbs () -> Array[Hash[Symbol, untyped]]
    def to_a
      result = [] #: Array[Hash[Symbol, untyped]]

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

    # @rbs!
    #   extend Base::ClassMethods
    with_validation :reveal_cell, :toggle_flag

    private

    # @rbs () -> Integer
    def count_empty_cell
      @cells.flatten.count(&:empty?)
    end
  end
end
