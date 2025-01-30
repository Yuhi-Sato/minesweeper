FactoryBot.define do
  factory :position do
    x { rand(0..100) }
    y { rand(0..100) }

    initialize_with do
      new(x:, y:)
    end
  end
end
