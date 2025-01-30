require_relative '../domains/cell_with_neighbors'

RSpec.describe CellWithNeighbors do
  describe '#initialize' do
    context '隣接する爆弾が0個のとき' do
      let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors: []) }

      it 'neighbor_bomb_cell_countが0であること' do
        expect(cell_with_neighbors.neighbor_bomb_cell_count).to eq 0
      end
    end

    context '隣接する爆弾が8個のとき' do
      let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors: Array.new(8) { build(:cell, bomb: true) }) }

      it 'neighbor_bomb_cell_countが8であること' do
        expect(cell_with_neighbors.neighbor_bomb_cell_count).to eq 8
      end
    end
  end

  describe '#neighbors' do
    let(:neighbors) { Array.new(8) { build(:cell_with_neighbors) } }
    let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors:) }

    it 'neighborsを返すこと' do
      expect(cell_with_neighbors.neighbors).to eq neighbors
    end

    it '返されたneighborsを変更しても#neighborsの結果が変更されないこと' do
      returned_neighbors = cell_with_neighbors.neighbors
      returned_neighbors.pop

      expect(returned_neighbors).not_to eq neighbors
      expect(cell_with_neighbors.neighbors).to eq neighbors
    end
  end

  describe '#add_neighbor' do
    let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors: []) }
    let(:neighbor_bomb) { build(:cell, bomb: true) }

    it 'neighborが追加されること' do
      cell_with_neighbors.add_neighbor(neighbor: neighbor_bomb)
      expect(cell_with_neighbors.neighbors).to eq [neighbor_bomb]
    end

    it 'neighbor_bomb_cell_countが1増加すること' do
      cell_with_neighbors.add_neighbor(neighbor: neighbor_bomb)
      expect(cell_with_neighbors.neighbor_bomb_cell_count).to eq 1
    end
  end

  describe '#count_revealed_cell' do
    context '隣接するセルが全て開かれていないとき' do
      let(:neighbors) { Array.new(8) { build(:cell_with_neighbors) } }
      let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors:) }

      it '0を返すこと' do
        expect(cell_with_neighbors.count_revealed_cell).to eq 0
      end
    end

    context '隣接するセルが全て開かれているとき' do
      let(:neighbors) { Array.new(8) { build(:cell_with_neighbors) } }
      let(:cell_with_neighbors) { build(:cell_with_neighbors, neighbors:) }

      before do
        neighbors.each(&:reveal)
      end

      it '8を返すこと' do
        expect(cell_with_neighbors.count_revealed_cell).to eq 8
      end
    end
  end

  describe '#reveal_with_neighbors' do
    context 'セルが既に開かれているとき' do
      let(:neighbors) { Array.new(8) { build(:cell_with_neighbors) } }
      let(:cell_with_neighbors) { build(:cell_with_neighbors) }

      before do
        cell_with_neighbors.reveal
      end

      it '隣接するセルを開かないこと' do
        cell_with_neighbors.reveal_with_neighbors
        neighbors.each do |neighbor|
          expect(neighbor.revealed?).to eq false
        end
      end
    end

    context 'セルが爆弾のとき' do
      let(:neighbors) { Array.new(8) { build(:cell_with_neighbors) } }
      let(:bomb_cell) { build(:cell, bomb: true) }
      let(:cell_with_neighbors) { build(:cell_with_neighbors, base: bomb_cell) }

      it 'セルを開くこと' do
        cell_with_neighbors.reveal_with_neighbors
        expect(cell_with_neighbors.revealed?).to eq true
      end

      it '隣接するセルを開かないこと' do
        cell_with_neighbors.reveal_with_neighbors
        neighbors.each do |neighbor|
          expect(neighbor.revealed?).to eq false
        end
      end
    end

    context 'セルが爆弾でない かつ 隣接する爆弾が0個のとき' do
      let(:empty_cell) { build(:cell, bomb: false) }
      let(:neighbors) do
        Array.new(8) do
          deep_neighbors = Array.new(8) { build(:cell_with_neighbors, base: empty_cell, neighbors: []) }
          build(:cell_with_neighbors, base: empty_cell, neighbors: deep_neighbors)
        end
      end
      let(:cell_with_neighbors) { build(:cell_with_neighbors, base: empty_cell, neighbors:) }

      it '隣接するセルを開くこと' do
        cell_with_neighbors.reveal_with_neighbors

        neighbors.each do |neighbor|
          expect(neighbor.revealed?).to eq true
        end
      end

      it '隣接するセルの爆弾でない隣接セルを開くこと' do
        cell_with_neighbors.reveal_with_neighbors

        neighbors.each do |neighbor|
          neighbor.neighbors.each do |deep_neighbor|
            expect(deep_neighbor.revealed?).to eq true
          end
        end
      end
    end

    context 'セルが爆弾でない かつ 隣接する爆弾が1個以上のとき' do
      let(:empty_cell) { build(:cell, bomb: false) }
      let(:bomb_cell) { build(:cell, bomb: true) }
      let(:bomb_neighbor) { build(:cell_with_neighbors, base: bomb_cell) }
      let(:neighbors) { Array.new(7) { build(:cell_with_neighbors) } + [bomb_neighbor] }
      let(:cell_with_neighbors) { build(:cell_with_neighbors, base: empty_cell, neighbors:) }

      it '隣接するセルを開かないこと' do
        cell_with_neighbors.reveal_with_neighbors

        neighbors.each do |neighbor|
          expect(neighbor.revealed?).to eq false
        end
      end
    end
  end
end
