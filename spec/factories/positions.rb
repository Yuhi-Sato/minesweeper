# frozen_string_literal: true

FactoryBot.define do
  factory :position, class: Domains::Position do
    x { rand(0..100) }
    y { rand(0..100) }

    initialize_with do
      new(x:, y:)
    end
  end
end
