require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  # examples
  # ABA
  # ABBA
  # ABCBA

  # even number: all characters must be even count
  # odd number: one character must have odd count

  count = Hash.new(0)
  string.chars.each { |ch| count[ch] += 1 }
  num_odd = 0

  count.values.each { |val| num_odd += 1 if val.odd? }

  if string.chars.count.even?
    num_odd == 0
  else
    num_odd == 1
  end
end
