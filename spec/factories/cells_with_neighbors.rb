FactoryBot.define do
  factory :cell_with_neighbors do
    bomb { [true, false].sample }
    neighbors { Array.new(rand(0..26)) { CellWithNeighbors.new(bomb: [true, false].sample) } }

    initialize_with do
      new(bomb:, neighbors:)
    end
  end
end
