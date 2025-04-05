# frozen_string_literal: true
# rbs_inline: enabled

require 'forwardable'

module Domains
  class CellWithNeighbors < Base
    extend Forwardable

    # @rbs @base: Cell
    # @rbs @neighbors: Array[CellWithNeighbors]
    # @rbs @neighbor_bomb_cell_count: Integer

    attr_reader :neighbor_bomb_cell_count #: Integer

    # @rbs (base: Cell, neighbors: Array[CellWithNeighbors]) -> void
    def initialize(base:, neighbors:)
      @base = base
      @neighbors = neighbors || []
      @neighbor_bomb_cell_count = count_neighbor_bomb_cell
    end

    # @rbs!
    #   def bomb?: () -> bool
    #   def empty?: () -> bool
    #   def flag?: () -> bool
    #   def revealed?: () -> bool
    #   def toggle_flag: () -> void
    #   def reveal: () -> void
    def_delegators :@base, :bomb?, :empty?, :flag?, :revealed?, :toggle_flag, :reveal

    # @rbs () -> Array[CellWithNeighbors]
    def neighbors
      @neighbors.dup
    end

    # @rbs (neighbor: CellWithNeighbors) -> void
    def add_neighbor(neighbor:)
      @neighbors << neighbor
      @neighbor_bomb_cell_count += 1 if neighbor.bomb?
    end

    # @rbs () -> void
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

    # @rbs () -> Integer
    def count_revealed_cell
      neighbors.count(&:revealed?)
    end

    private

    # @rbs () -> Integer
    def count_neighbor_bomb_cell
      neighbors.count(&:bomb?)
    end
  end
end
