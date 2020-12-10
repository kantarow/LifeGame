class LifeGame
  ALIVE = 1
  DEAD = 0

  def initialize(width, height, initial_cells, x=0, y=0)
    @width = width
    @height = height
    @current_board = Array.new(@width) { Array.new(@height, DEAD) }
    @next_board = Array.new(@width) { Array.new(@height, DEAD) }

    initial_cells.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @current_board[x+i][y+j] = cell
      end
    end
  end

  def update
    @current_board.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        count = count_around_cell(x, y)
        transition_cell(x, y, count)
      end
    end

    @current_board = Marshal.load(Marshal.dump(@next_board))
  end

  def get_board
    @current_board
  end

  def self.alive?(cell)
    cell == ALIVE
  end

  private

  def alive?(x, y)
    x >= 0 && x < @width && y >= 0 && y < @height && @current_board[x][y] == ALIVE
  end

  def count_around_cell(x, y)
    sum = 0
    (x-1).upto(x+1).each do |i|
      (y-1).upto(y+1).each do |j|
        sum += 1 if alive?(i, j) && (i != x || j != y)
      end
    end

    sum
  end     

  def transition_cell(x, y, count)
    status = @current_board[x][y]
    is_alive = LifeGame.alive?(status)

    if !is_alive && count == 3
      @next_board[x][y] = ALIVE
    elsif is_alive && (count == 2 || count == 3)
      @next_board[x][y] = ALIVE
    elsif is_alive && count <= 1
      @next_board[x][y] = DEAD
    elsif is_alive && count >= 4
      @next_board[x][y] = DEAD
    else
      @next_board[x][y] = status
    end
  end
end
