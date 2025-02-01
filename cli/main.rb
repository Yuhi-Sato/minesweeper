#!/usr/bin/env ruby

Dir.glob(File.expand_path('../domains/validators/*.rb', __dir__)).sort.each do |file|
  require file
end

Dir.glob(File.expand_path('../domains/*.rb', __dir__)).sort.each do |file|
  require file
end


def prompt_command
  print "\nコマンドを入力してください（例: reveal 2 3 / flag 1 1 / exit）: "
  gets.chomp
end

def parse_command(input)
  input.split
end

if __FILE__ == $0
  game = Domains::Minesweeper.new

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
