# frozen_string_literal: true

# creating an instance of this class starts the game
class Game

  # the grid structure:
  # [0,1,2]
  # [3,4,5]
  # [6,7,8]

  WINNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                    [0, 3, 6], [1, 4, 7], [2, 5, 8],
                    [0, 4, 8], [2, 4, 6]]

  def initialize
    @game_over = false
    @turn_number = 0
    @grid = Array.new(9)
    puts 'A game of Tic Tac Toe!'
    puts 'Here is what the board looks like:'
    puts "\n\t1|2|3\n\t4|5|6\n\t7|8|9"
    puts "\n"
    print "Turn 1: Let's begin, "
    play
  end

  def print_grid
    column = '|'
    # fg = formatted grid, replacing all nil values
    fg = @grid.map { |e| e || '-' }
    puts "\n"
    puts "\t#{fg[0]}#{column}#{fg[1]}#{column}#{fg[2]}"
    puts "\t#{fg[3]}#{column}#{fg[4]}#{column}#{fg[5]}"
    puts "\t#{fg[6]}#{column}#{fg[7]}#{column}#{fg[8]}"
    puts "\n"
  end

  def play
    until @game_over
      print 'please enter a number 1-9: '
      selection = gets[0].to_i - 1
      if free_positions.include?(selection)
        @turn_number += 1
        player = x_or_o
        add_selection(selection, player)
        print_grid
        game_over_conditions
      else
        print_grid
        print 'Oops! That space is already taken, '
      end
    end
  end

  def x_or_o
    @turn_number.odd? ? 'X' : 'O'
  end

  def add_selection(index, selection)
    @grid[index] = selection
  end

  def free_positions
    (0..8).select { |element| @grid[element].nil? }
  end

  def game_over_conditions
    if WINNING_COMBOS.any? do |combo|
      combo.all? { |position| @grid[position] == 'X' }
    end
      @game_over = true
      puts "Player X wins on turn #{@turn_number}!"
    elsif WINNING_COMBOS.any? do |combo|
      combo.all? { |position| @grid[position] == 'O' }
    end
      @game_over = true
      puts "Player O wins on turn #{@turn_number}!"
    elsif free_positions.empty?
      @game_over = true
      puts 'It is a tie!'
    else
      print "Turn #{@turn_number + 1}: Next player's turn, "
    end
  end
end
