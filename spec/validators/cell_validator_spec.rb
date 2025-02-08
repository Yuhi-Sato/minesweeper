# frozen_string_literal: true

RSpec.describe Domains::Validators::CellValidator do
  describe '#validate_toggle_flag!' do
    context 'セルが既に開かれているとき' do
      let(:cell) { build(:cell) }

      before do
        cell.reveal
      end

      it 'Domains::Validators::Errorが発生すること' do
        expect { cell.reveal }.to raise_error(Domains::Validators::Error)
      end
    end
  end

  describe '#validate_reveal!' do
    context 'セルが既に開かれているとき' do
      let(:cell) { build(:cell) }

      before do
        cell.reveal
      end

      it 'Domains::Validators::Errorが発生すること' do
        expect { cell.reveal }.to raise_error(Domains::Validators::Error)
      end
    end
  end
end
