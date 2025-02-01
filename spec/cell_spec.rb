RSpec.describe Domains::Cell do
  describe '#bomb?' do
    context '爆弾であるとき' do
      let(:cell) { build(:cell, bomb: true) }

      it 'trueを返すこと' do
        expect(cell.bomb?).to eq true
      end
    end

    context '爆弾でないとき' do
      let(:cell) { build(:cell, bomb: false) }

      it 'falseを返すこと' do
        expect(cell.bomb?).to eq false
      end
    end
  end

  describe '#empty?' do
    context '爆弾であるとき' do
      let(:cell) { build(:cell, bomb: true) }

      it 'falseを返すこと' do
        expect(cell.empty?).to eq false
      end
    end

    context '爆弾でないとき' do
      let(:cell) { build(:cell, bomb: false) }

      it 'trueを返すこと' do
        expect(cell.empty?).to eq true
      end
    end
  end

  describe '#flag? と #toggle_flag の組み合わせ' do
    context '初期状態のとき' do
      let(:cell) { build(:cell) }

      it 'falseを返すこと' do
        expect(cell.flag?).to eq false
      end
    end

    context 'フラグを立てたとき' do
      let(:cell) { build(:cell) }

      before do
        cell.toggle_flag
      end

      it 'trueを返すこと' do
        expect(cell.flag?).to eq true
      end
    end

    context 'フラグを立てた後にフラグを解除したとき' do
      let(:cell) { build(:cell) }

      before do
        cell.toggle_flag
        cell.toggle_flag
      end

      it 'falseを返すこと' do
        expect(cell.flag?).to eq false
      end
    end
  end

  describe '#revealed? と #reveal の組み合わせ' do
    context '初期状態のとき' do
      let(:cell) { build(:cell) }

      it 'falseを返すこと' do
        expect(cell.revealed?).to eq false
      end
    end

    context 'セルを開いたとき' do
      let(:cell) { build(:cell) }

      before do
        cell.reveal
      end

      it 'trueを返すこと' do
        expect(cell.revealed?).to eq true
      end
    end
  end
end
