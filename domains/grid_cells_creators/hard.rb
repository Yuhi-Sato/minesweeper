module Domains
  module GridCellsCreators
    class Hard < Base
      WIDTH = 16
      HEIGHT = 16
      NUM_BOMBS = 40

      def create
        Utils.random_create(width: WIDTH, height: HEIGHT, num_bombs: NUM_BOMBS)
      end
    end
  end
end
