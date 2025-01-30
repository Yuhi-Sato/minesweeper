FactoryBot.define do
  factory :cell_with_neighbors do
    base { build(:cell) }
    neighbors { Array.new(rand(0..26)) { CellWithNeighbors.new(base: build(:cell)) } }

    initialize_with do
      new(base:, neighbors:)
    end
  end
end
