class GridCells
  attr_reader :num_empties

  NUM_NEIGHBORS = 8
  DX = [0, 1, 1, 1, 0, -1, -1, -1]
  DY = [-1, -1, 0, 1, 1, 1, 0, -1]

  def initialize(width: 9, height: 9, num_bombs: 10)
    @width = width
    @height = height
    @num_cells = width * height
    @num_bombs = num_bombs
    @num_empties = @num_cells - @num_bombs
    @data = build_data
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

  # TODO: 別クラスに実装する
  def display
    print "  "

    @data.first.each_with_index do |row, x|
      print "#{x} "
    end

    puts

    print "  "

    @data.first.each do |row, x|
      print "--"
    end

    puts

    @data.each_with_index do |row, y|
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

  private

  # NOTE: ランダムにセルを生成するメソッド
  def build_data
    cells = Array.new(@num_bombs) { CellWithNeighbors.new(base: Cell.new(bomb: true)) } +
            Array.new(@num_cells - @num_bombs) {  CellWithNeighbors.new(base: Cell.new(bomb: false)) }

    data = cells.shuffle.each_slice(@width).to_a

    data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        coordinations(x:, y:).each do |nx, ny|
          cell.add_neighbor(neighbor: data[ny][nx])
        end
      end
    end

    data
  end

  def coordinations(x:, y:)
    NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
      .select { |nx, ny| nx.between?(0, @width - 1) && ny.between?(0, @height - 1) }
  end
end
