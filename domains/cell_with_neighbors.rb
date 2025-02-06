# frozen_string_literal: true

require 'forwardable'

module Domains
  class CellWithNeighbors < Base
    extend Forwardable

    attr_reader :neighbor_bomb_cell_count

    def initialize(base:, neighbors: [])
      @base = base
      @neighbors = neighbors
      @neighbor_bomb_cell_count = count_neighbor_bomb_cell
    end

    def_delegators :@base, :bomb?, :empty?, :flag?, :revealed?, :toggle_flag, :reveal

    def neighbors
      @neighbors.dup
    end

    def add_neighbor(neighbor:)
      @neighbors << neighbor
      @neighbor_bomb_cell_count += 1 if neighbor.bomb?
    end

    def reveal_with_neighbors
      reveal

      # NOTE: 選択したセルが爆弾の場合は再帰処理を終了
      return if bomb?

      # NOTE: 隣接したセルに爆弾がある場合は再帰処理を終了
      return unless neighbor_bomb_cell_count.zero?

      neighbors.each do |neighbor|
        neighbor.reveal_with_neighbors unless neighbor.revealed?
      end
    end

    def count_revealed_cell
      neighbors.count(&:revealed?)
    end

    private

    def count_neighbor_bomb_cell
      neighbors.count(&:bomb?)
    end
  end
end
