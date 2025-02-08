# frozen_string_literal: true

RSpec.describe Domains::Position do
  describe '#x' do
    let(:x) { rand(0..100) }
    let(:position) { build(:position, x:) }

    it 'xを返すこと' do
      expect(position.x).to eq x
    end
  end

  describe '#y' do
    let(:y) { rand(0..100) }
    let(:position) { build(:position, y:) }

    it 'yを返すこと' do
      expect(position.y).to eq y
    end
  end
end
