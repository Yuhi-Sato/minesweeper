#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'validators/base'
require_relative 'validators/cell_validator'
require_relative 'validators/grid_cells_validator'
require_relative 'validators/position_validator'

require_relative 'base'
require_relative 'cell_with_neighbors'
require_relative 'cell'
require_relative 'grid_cells_factory'
require_relative 'grid_cells'
require_relative 'position'

def prompt_command
  print "\nコマンドを入力してください（例: reveal 2 3 / flag 1 1 / exit）: "
  gets.chomp
end

def parse_command(input)
  input.split
end

if __FILE__ == $PROGRAM_NAME
  puts '難易度を選択してください。'
  puts '1: 簡単'
  puts '2: 普通'
  puts '3: 難しい'

  difficulty = case gets.chomp
               when '1'
                 Domains::Minesweeper::EASY
               when '2'
                 Domains::Minesweeper::NORMAL
               when '3'
                 Domains::Minesweeper::HARD
               end

  game = Domains::Minesweeper.new(difficulty)

  until game.finished?
    begin
      game.grid_cells.display

      input = prompt_command
      command, x_str, y_str = parse_command(input)

      case command
      when 'reveal', 'r'
        if x_str && y_str
          x = x_str.to_i
          y = y_str.to_i
          game.reveal_cell(x, y)
        else
          puts "座標が正しくありません。例: 'reveal 2 3'"
        end
      when 'flag', 'f'
        if x_str && y_str
          x = x_str.to_i
          y = y_str.to_i
          game.toggle_flag(x, y)
        else
          puts "座標が正しくありません。例: 'flag 1 1'"
        end
      when 'exit', 'e'
        puts 'ゲームを終了します。'
        exit
      else
        puts "不明なコマンドです。'reveal x y', 'flag x y', 'exit'を使用してください。"
      end

      if game.finished?
        puts "\nゲーム終了！"
        game.grid_cells.display
        if game.grid_cells.bombed?
          puts '爆弾を開いてしまいました…'
        else
          puts 'おめでとうございます！地雷を回避して全てのセルを開きました！'
        end
        break
      end
    rescue StandardError => e
      puts e.message
    end
  end
end
