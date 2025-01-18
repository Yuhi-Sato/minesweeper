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
    game.board.display

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
