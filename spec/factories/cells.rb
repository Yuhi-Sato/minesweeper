FactoryBot.define do
  factory :cell, class: Domains::Cell do
    bomb { [true, false].sample }

    initialize_with do
      new(bomb:)
    end
  end
end
