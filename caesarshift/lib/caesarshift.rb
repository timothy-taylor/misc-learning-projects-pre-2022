class CaesarShift
  attr_accessor :word, :key

  def initialize(word = '', key = '')
    @word = word
    @key = key
  end

  def enter_the_cipher
    print "Enter a word to encode: "
    @word = gets
    print "Enter a number to act as a key: "
    @key = gets[0].to_i
    puts caesar_cipher
  end

  def caesar_cipher(string = @word, shift = @key)
    word_array = string.split('')
    shifted_array = word_array.map{ |letter| char_shift(letter, shift) }
    shifted_array.join('')
  end

  def wrapping_utility(code, shift)
    new_shift = ( shift % 26 ) + 26
    ascii_anchor = ( code >= 97 ) ? 97 : 65
    difference = code - ascii_anchor
    remainder = ( difference + new_shift ) % 26
    return (remainder + ascii_anchor)
  end

  def char_shift(char, shift)
    char_code = char.ord 
    if ( char_code >= 65 && char_code <= 90 )
      new_code = wrapping_utility(char_code,shift)
      new_character = new_code.chr
    elsif ( char_code >= 97 && char_code <= 122 )
      new_code = wrapping_utility(char_code,shift)
      new_character = new_code.chr
    else
      # this returns punctuations, spaces, etc
      return char
    end
  end 
end
