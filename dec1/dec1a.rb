
filename = 'input.txt'

# Check if the file exists
if File.exist?(filename)
  sum = 0

  File.open(filename, 'r') do |file|

    # Read each line in the file
    file.each_line do |line|
      # Extract all digits from the string into an array
      digits = line.scan(/\d/)

      first_digit = digits.first
      last_digit = digits.last

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

