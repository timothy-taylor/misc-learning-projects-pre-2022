def stock_picker(array)
  current_result = 0
  best_result = 0
  resulting_pair = []

  array.combination(2) do |pair|
    current_result = pair[1] - pair[0]
    if current_result > best_result
      best_result = current_result
      resulting_pair = [pair[0], pair[1]]
    end
  end

  puts "The most profitable combination of days are: #{resulting_pair}"

  ix_array = (0..array.length).to_a.combination(2).detect do |pair|
    resulting_pair == [array[pair[0]], array[pair[1]]]
  end

  puts "So buy / sell on days: #{ix_array}"

end

test = [17,3,6,9,15,8,6,1,10]
randomly_generated_test_array = Array.new(10) { rand(1...20) }
puts "Prices: #{randomly_generated_test_array}"

stock_picker(randomly_generated_test_array)
