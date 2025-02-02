module Domains
  module GridCellsCreators
    class Normal < Base
      WIDTH = 9
      HEIGHT = 9
      NUM_BOMBS = 10

      def create
        Utils.random_create(width: WIDTH, height: HEIGHT, num_bombs: NUM_BOMBS)
      end
    end
  end
end
