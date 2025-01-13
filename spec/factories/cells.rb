FactoryBot.define do
  factory :cell do
    bomb { [true, false].sample }

    initialize_with do
      new(bomb:)
    end
  end
end
