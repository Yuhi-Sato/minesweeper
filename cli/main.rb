#!/usr/bin/env ruby

require_relative '../entity/cell'
require_relative '../entity/cell_with_neighbors'
require_relative '../entity/factory/grid_cell_factory'
require_relative '../entity/board'
require_relative '../entity/minesweeper'

def display_board(board)
  board.grid_cells.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell.revealed?
        if cell.bomb?
          print "B "
        else
          print "#{cell.neighbor_bomb_cell_count} "
        end
      else
        if cell.flag?
          print "F "
        else
          print "□ "
        end
      end
    end
    puts
  end
end

def prompt_command
  print "\nコマンドを入力してください（例: reveal 2 3 / flag 1 1 / exit）: "
  gets.chomp
end

def parse_command(input)
  # 例: "reveal 2 3" → ["reveal", "2", "3"]
  input.split
end

if __FILE__ == $0
  # ゲーム設定の入力 (任意で固定値でもOK)
  print "幅を入力してください (width): "
  width = gets.to_i

  print "高さを入力してください (height): "
  height = gets.to_i

  print "地雷の数を入力してください (num_bombs): "
  num_bombs = gets.to_i

  # Minesweeperクラスを初期化
  game = Minesweeper.new(width:, height:, num_bombs:)

  # ゲームが続く限りループ
  until game.finished?
    # 盤面表示
    display_board(game.board)

    # ユーザーのコマンド入力
    input = prompt_command
    command, x_str, y_str = parse_command(input)

    # コマンド別の処理
    case command
    when "reveal"
      if x_str && y_str
        x, y = x_str.to_i, y_str.to_i
        game.reveal_cell(x, y)
      else
        puts "座標が正しくありません。例: 'reveal 2 3'"
      end
    when "flag"
      if x_str && y_str
        x, y = x_str.to_i, y_str.to_i
        game.toggle_flag(x, y)
      else
        puts "座標が正しくありません。例: 'flag 1 1'"
      end
    when "exit"
      puts "ゲームを終了します。"
      exit
    else
      puts "不明なコマンドです。'reveal x y', 'flag x y', 'exit'を使用してください。"
    end

    # ゲーム終了チェック
    if game.finished?
      puts "\nゲーム終了！"
      display_board(game.board)
      if game.board.bombed?
        puts "爆弾を開いてしまいました…"
      else
        puts "おめでとうございます！地雷を回避して全てのセルを開きました！"
      end
      break
    end
  end
end
