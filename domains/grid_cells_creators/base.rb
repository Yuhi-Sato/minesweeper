module Domains
  module GridCellsCreators
    class Base
      def create
        raise NotImplementedError, "#{self.class}##{__method__} is must be implemented"
      end
    end
  end
end
