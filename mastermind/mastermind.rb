# frozen_string_literal: true

require 'io/console'

class Game
  attr_reader :game_over, :secret_code
  attr_accessor :number_of_turns

  CODE_CHAR = ('a'..'f').to_a

  def initialize(mastermind, codebreaker)
    @game_over = false
    @number_of_turns = 0
    @mastermind = mastermind
    @codebreaker = codebreaker
    @secret_code = choose_code(@mastermind)
  end

  def new_round
    Round.new(self, @codebreaker)
  end

  def choose_code(player_or_generated)
    player_or_generated == 0 ? generated_code : player_code
  end

  def player_code
    puts "Enter your 4 letter code from the pool of [ a, b, c, d, e, f ];"
    print "Press return when satisified: "
    code = STDIN.noecho(&:gets).chomp.split('').to_a
    if code.all?('a'..'f') && code.length == 4
      puts "Code entered successfully."
      return code
    else
      puts "Your secret code did not match the game rules! Try again!"
      player_code
    end
  end

  def generated_code
    i = 0
    code = []
    until i == 4
      code[i] = CODE_CHAR[rand(6).to_i]
      i += 1
    end
    return code
  end

  def game_over_conditions(player_guess)
    if @secret_code.eql?(player_guess)
      @game_over = true
      p @secret_code
      puts "You broke the secret code! Well done!"
    elsif @number_of_turns >= 8
      @game_over = true
      puts "The codebreaker ran out of chances! The mastermind wins!"
      puts "The secret code was #{@secret_code}."
    end
  end
end

class Round
  def initialize(game, codebreaker)
    @game = game
    @game.number_of_turns += 1
    @guess = (codebreaker == 0) ? computer_guess : player_guess
    code_check(@guess, @game.secret_code)
  end

  def computer_guess
    unless @game.number_of_turns == 1
      print "Ready for the next round? Press enter to continue: "
      gets
    end
    cpu_guess = @game.generated_code
    puts "The computer guesses #{cpu_guess}..."
    return cpu_guess
  end


  def player_guess
    print "Guess the secret 4-letter code! [ a, b, c, d, e, f ]: "
    guess = gets.chomp.split('').to_a
    unless guess.length == 4 && guess.all?('a'..'f')
      puts "Your guess doesn't meet the criteria! Try again."
      player_guess
    else
      return guess
    end
  end

  def code_check(guess, secret_code)
    duplicate_check = []
    correct_guesses = 0
    half_right_guesses = 0

    puts "Turn #{@game.number_of_turns}: Checking the code..."
    
    @game.game_over_conditions(guess)
    if @game.game_over
      return
    else
      guess.each_with_index { |guess, ix|
        if guess == secret_code[ix]
          unless duplicate_check.include?(ix)
            correct_guesses += 1
            duplicate_check.push(ix)
          end
        end
      }
      guess.each_with_index { |guess, ix| 
        i = 0
        until i == 4
          if guess == secret_code.uniq[i]
            unless duplicate_check.include?(i)
              half_right_guesses += 1
              duplicate_check.push(i)
            end
          end
          i += 1
        end
      }
    end
    puts "The codebreaker had #{correct_guesses} exact guesses and #{half_right_guesses} close guesses."
  end
end

puts "Let's play 8 rounds of Mastermind!"
print "Who is the mastermind? Enter [0,1]; computer[0] or human[1]: "
who_is_mastermind = gets[0].to_i
print "Who is the codebreaker? Enter [0,1]; computer[0] or human[1]: "
who_is_codebreaker = gets[0].to_i
lets_play = Game.new(who_is_mastermind, who_is_codebreaker)
until lets_play.game_over
  lets_play.new_round
end
