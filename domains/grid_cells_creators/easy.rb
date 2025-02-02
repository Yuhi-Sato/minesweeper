module Domains
  module GridCellsCreators
    class Easy < Base
      WIDTH = 5
      HEIGHT = 5
      NUM_BOMBS = 3

      def create
        Utils.random_create(width: WIDTH, height: HEIGHT, num_bombs: NUM_BOMBS)
      end
    end
  end
end
