class Grid
  def create_grid
    Array.new(7) {Array.new(7)}
  end

  def print_grid(board)
    board.each { |row|
      p row
    }
  end

end

class Gameplay < Grid
  attr_accessor :board, :turn_number, :game_over

  def initialize
    @board = create_grid
    @turn_number = 0
    @game_over = false
  end

  def random_generator
    until @game_over
      play_piece(rand(6))
      win_conditions
    end
    print_grid(@board)
    return @game_over
  end

  def play_piece(column, player = take_turns, row = 6)
    until @board[row][column].nil?
      row -= 1
    end
    return if row == 0 && @board[row][column] != nil
    @board[row][column] = player
    @turn_number += 1
    return @board
  end

  def take_turns
    player = @turn_number.even? ? 'X' : 'O'
    return player
  end

  def win_conditions(board = @board, player = take_turns)
    tie = @turn_number >= 49 ? true : false
    h_win = horizontal_check(board, player)
    v_win = vertical_check(board, player)
    d_win = diagonal_check(board, player)
    @game_over = true if h_win || v_win || d_win
    return @game_over
  end

  def diagonal_check(board, player)
    diagonal = []
    i = 0
    while i <= 7
      array = []
      board.each_with_index { |row, ix|
        array.push(row[i-ix])
      }
      diagonal.push(array)
      i += 1
    end
    return horizontal_check(diagonal, player)
  end

  def vertical_check(board, player)
    vertical = []
    i = 0
    while i <= 7 
      array = []
      board.each { |row|
        array.push(row[i])
      }
      vertical.push(array)
      i += 1
    end
    return horizontal_check(vertical, player)
  end

  def horizontal_check(board, player)
    board.any? { |row|
      case 
      when row[0..3].all? { |e| e == player }
        true
      when row[1..4].all? { |e| e == player }
        true
      when row[2..5].all? { |e| e == player }
        true
      when row[3..6].all? { |e| e == player }
        true
      end
    }
  end
end
