require_relative './life_game.rb'

def display(life_game)
  board = life_game.get_board
  board.each do |row|
    row.each do |cell|
      print(LifeGame.alive?(cell) ? '#' : ' ')
    end
    puts
  end
end

cells = [
  [1, 1, 1],
  [1, 0, 0],
  [0, 1, 0],
].map {|row| row.map {|cell| cell == 1 ? LifeGame::ALIVE : LifeGame::DEAD }}

life_game = LifeGame.new(30, 30, cells, 13, 13)

loop do
  display(life_game)
  print("\n#{'-' * 30}\n\n")
  life_game.update
  sleep(0.5)
end
