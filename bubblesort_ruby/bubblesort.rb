def bubble_sort(array)
  swap_var = 0
  n = array.length-1
  j = 0

  while j < n do
    i = 0
    while i < n do
      if array[i] > array[i+1]
        swap_var = array[i]
        array[i] = array[i+1]
        array[i+1] = swap_var
      end
      i += 1
    end
    j += 1
  end

  p array
end

randomly_generated_test_array = Array.new(10) { rand(-5...20) }

bubble_sort(randomly_generated_test_array)
