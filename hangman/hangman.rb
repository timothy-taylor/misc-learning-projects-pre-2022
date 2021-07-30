# frozen_string_literal = true

require 'msgpack'

class Game
  attr_accessor :num_of_guesses, :working_array, :play_on, :word, :game_saved

  def initialize(word, num, current)
    @word = word
    @num_of_guesses = num
    @working_array = current
    @play_on = true
    @game_saved = false
  end

  def new_round
    Round.new(self)
  end
 
  def game_over_conditions
    if @game_saved
      puts "Game saved."
      play_on = false
    elsif @working_array == @word
      puts "You win!"
      play_on = false
    elsif @num_of_guesses >= 8
      puts "You ran out of guesses!"
      puts "The word was: #{@word}"
      play_on = false
    else
      play_on = true
    end
  end

  def save_game
    game_state = { :word => @word, :turn => @num_of_guesses,
                   :current => @working_array
    }.to_msgpack
    
    File.open("lib/.save", "w"){ |file| file.write(game_state) }
    @game_saved = true
  end

end

class Round
  def initialize(game)
    @game = game
    @word = game.word
    @guess = player_guess
    word_check(@word, @guess) unless @game.game_saved
  end

  def word_check(word, guess)
    no_letter_found = true
    word.downcase.split('').each_with_index { |letter, ix|
      if letter == guess
        @game.working_array[ix] = guess
        no_letter_found = false
      end
    }
    @game.num_of_guesses += 1 if no_letter_found
    fmt_w_array = @game.working_array.map { |e| e || '_' }
    puts fmt_w_array.join(' ')
  end

  def player_guess
    print "You have #{8-@game.num_of_guesses} guesses left; guess a letter, or type 'save' to save and quit: "
    guess = gets.chomp.downcase
    if guess == 'save'
      @game.save_game
    else
      unless guess.chomp.length == 1 && ('a'..'z').include?(guess)
        puts "Incorrect input, please guess only one letter!"
        player_guess
      else
        return guess
      end
    end
  end

end

class Start
  def initialize
    puts `clear`
    puts "Let's play hangman!"
    @new_game
    check_for_saved_game
  end

  def check_for_saved_game
    print "Would you like to load a previously saved game? Yes[0] No[1]: "
    @new_game = gets[0].to_i
    unless (0..1).include?(@new_game)
      puts "Sorry, I didn't get that..."
      check_for_saved_game
    else
      if @new_game == 1
        play_new_game
      else
        load_game
      end
    end
  end

  def play_new_game
    @word = word_finder
    @num_of_guesses = 0
    @working_array = Array.new(@word.length)
    
    hangman = Game.new(@word, @num_of_guesses, @working_array)
    while hangman.game_over_conditions
      hangman.new_round
    end
  end

  def load_game
    game_state = File.open("lib/.save", "r"){ |file| file.read }
    loaded = MessagePack.unpack(game_state)
    puts "Game loaded."
    @l_word = loaded.fetch("word")
    @l_turn = loaded.fetch("turn")
    @l_current = loaded.fetch("current")
    
    hangman = Game.new(@l_word, @l_turn, @l_current)
    while hangman.game_over_conditions
      hangman.new_round
    end
  end

  private

  def word_finder
    File.open("lib/5desk.txt", "r"){ |file|
      words = file.readlines
      word = words[rand(words.length)].strip
      unless word.length.between?(5, 12)
        word_finder
      else
        puts "New game! The word is #{word.length} letters long."
        return word
      end
    }
  end

end

lets_play = Start.new
