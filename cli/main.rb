#!/usr/bin/env ruby

require_relative '../domains/cell'
require_relative '../domains/cell_with_neighbors'
require_relative '../domains/position'
require_relative '../domains/grid_cells'
require_relative '../domains/board'
require_relative '../domains/minesweeper'

def prompt_command
  print "\nコマンドを入力してください（例: reveal 2 3 / flag 1 1 / exit）: "
  gets.chomp
end

def parse_command(input)
  input.split
end

if __FILE__ == $0
  # TODO: モードでwidth, height, num_bombsを変更する
  # print "幅を入力してください (width): "
  # width = gets.to_i

  # print "高さを入力してください (height): "
  # height = gets.to_i

  # print "地雷の数を入力してください (num_bombs): "
  # num_bombs = gets.to_i

  game = Minesweeper.new(width: 9, height: 9, num_bombs: 10)

  until game.finished?
    game.board.display

    input = prompt_command
    command, x_str, y_str = parse_command(input)

    case command
    when "reveal", "r"
      if x_str && y_str
        x, y = x_str.to_i, y_str.to_i
        game.reveal_cell(x, y)
      else
        puts "座標が正しくありません。例: 'reveal 2 3'"
      end
    when "flag", "f"
      if x_str && y_str
        x, y = x_str.to_i, y_str.to_i
        game.toggle_flag(x, y)
      else
        puts "座標が正しくありません。例: 'flag 1 1'"
      end
    when "exit", "e"
      puts "ゲームを終了します。"
      exit
    else
      puts "不明なコマンドです。'reveal x y', 'flag x y', 'exit'を使用してください。"
    end

    if game.finished?
      puts "\nゲーム終了！"
      game.board.display
      if game.board.bombed?
        puts "爆弾を開いてしまいました…"
      else
        puts "おめでとうございます！地雷を回避して全てのセルを開きました！"
      end
      break
    end
  end
end
