def fibonacci_like?(sequence)
  result = sequence.select.with_index do |n, i|
    i == 0 || i == 1 ||
    n == sequence[i - 2] + sequence[i - 1]
  end
  (sequence - result).empty?
end