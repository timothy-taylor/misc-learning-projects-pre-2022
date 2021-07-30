dictionary = ["below","down","go","going","horn","how","howdy","it",
              "i","low","own","part","partner","sit"]

def substrings(string, array)
  format_string = string.downcase.gsub(/[^a-z0-9\s]/i, '')
  string_finding_results = Hash.new
  array.each { |word|
    if ( format_string.include?(word) )
      n = format_string.scan(word).length 
      string_finding_results[word] = n
    end
    }
  
  puts string_finding_results
end

puts "Please enter a phrase to check against the dictionary"
user_string = gets

substrings(user_string, dictionary)
