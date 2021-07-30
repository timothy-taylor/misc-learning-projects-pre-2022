# frozen_string_literal : true

def merge_sort(array)
  if array.length <= 1
    return array
  else
    middle = array.length / 2
    left_array = merge_sort( array.slice(0...middle) )
    right_array = merge_sort( array.slice(middle..array.length) )

    return merge(left_array, right_array)
  end
end

def merge(left, right)
  result = []
  until left.empty? || right.empty? do
    result.push( left[0] < right[0] ? left.shift : right.shift )
  end

  return result.concat(left).concat(right)
end

random_array = Array.new(rand(50)) { rand(-20...200) }
p merge_sort(random_array)
