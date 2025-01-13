class NeighborCoordination
  NUM_NEIGHBORS = 8
  DX = [0, 1, 1, 1, 0, -1, -1, -1]
  DY = [-1, -1, 0, 1, 1, 1, 0, -1]

  def initialize(width:, height:)
    @width = width
    @height = height
  end

  def coordinations(x:, y:)
    NUM_NEIGHBORS.times.map { |i| [x + DX[i], y + DY[i]] }
      .select { |nx, ny| nx.between?(0, @width - 1) && ny.between?(0, @height - 1) }
  end
end
