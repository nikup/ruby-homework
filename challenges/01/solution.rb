def common_digits_count(first, second)
  (first.to_s.split('') & second.to_s.split('')).length
end