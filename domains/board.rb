class Board
  def initialize(grid_cells:)
    @grid_cells = grid_cells
  end

  def reveal_cell(position:)
    @grid_cells.reveal_with_neighbors(position:)
  end

  def toggle_flag(position:)
    @grid_cells.toggle_flag(position:)
  end

  def count_revealed_cell
    @grid_cells.count_revealed_cell
  end

  def bombed?
    @grid_cells.bombed?
  end

  def num_empties
    @grid_cells.num_empties
  end

  # TODO: 別クラスに実装する
  def display
    print "  "

    @grid_cells.data.first.each_with_index do |row, x|
      print "#{x} "
    end

    puts

    print "  "

    @grid_cells.data.first.each do |row, x|
      print "--"
    end

    puts

    @grid_cells.data.each_with_index do |row, y|
      print "#{y}|"

      row.each do |cell|
        if cell.revealed?
          if cell.bomb?
            print "B "
          elsif cell.count_revealed_cell == cell.neighbors.size
            print "◻︎ "
          else
            print "#{cell.neighbor_bomb_cell_count} "
          end
        else
          if cell.flag?
            print "F "
          else
            print "◼︎ "
          end
        end
      end
      puts
    end
  end
end
