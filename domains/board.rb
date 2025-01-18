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
    @grid_cells.data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell.revealed?
          if cell.bomb?
            print "B "
          else
            print "#{cell.neighbor_bomb_cell_count} "
          end
        else
          if cell.flag?
            print "F "
          else
            print "□ "
          end
        end
      end
      puts
    end
  end
end
