
filename = 'input.txt'

num_words = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}
reversed_num_words = num_words.transform_keys { |key| key.reverse }

def find_digit(str, num_words)
  first_digit_index = str.index(/\d/)

  # Create a regex from num_words keys and find the first match
  num_words_regex = Regexp.union(num_words.keys)
  first_num_word_match = str.match(num_words_regex)
  first_num_word_index = first_num_word_match ? first_num_word_match.begin(0) : nil

  if first_num_word_index.nil? || first_digit_index < first_num_word_index
    str[first_digit_index]
  else
    num_words[first_num_word_match[0]]
  end
end

# Check if the file exists
if File.exist?(filename)
  sum = 0

  File.open(filename, 'r') do |file|

    # Read each line in the file
    file.each_line do |line|
      first_digit = find_digit(line, num_words)
      last_digit = find_digit(line.reverse, reversed_num_words)

      two_digit = "#{first_digit}#{last_digit}"

      puts line
      puts two_digit

      sum += two_digit.to_i
      puts sum
    end
  end
  puts "sum: #{sum}"
else
  puts "File not found: #{filename}"
end

