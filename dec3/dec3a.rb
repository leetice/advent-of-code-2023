
filename = 'input.txt'

def symbol_adjacent?(char)
  char.match?(/[^a-zA-Z0-9.]/)
end

def sum_of_part_numbers_for_line(previous_line, current_line, next_line)
  sum = 0

  # Regular expression to match a sequence of digits
  pattern = /\d+/

  # Enumerate over each match with its index
  current_line.enum_for(:scan, pattern).each do
    match = Regexp.last_match
    number = match[0]             # The matched number
    index = match.begin(0)        # The start index of the match in the string
    length = number.length        # The length of the matched number

    # Check if the number has a symbol adjacent to it
    for i in index-1..index+length
      if (symbol_adjacent?(current_line[i]) || symbol_adjacent?(previous_line[i]) || symbol_adjacent?(next_line[i]))
        puts "Adding #{number}"
        sum += number.to_i
        break
      end
    end
  end

  sum
end

# Check if the file exists
if File.exist?(filename)
  sum_of_part_numbers = 0

  # Open the file
  File.open(filename, 'r') do |file|
    current_line = '.' + file.gets.chomp + '.'
    previous_line = '.' * current_line.length

    # Read each line in the file
    while (next_line = file.gets)
      # Remove the newline character at the end of the line
      next_line = '.' + next_line.chomp + '.'

      # Process the line
      sum_of_part_numbers += sum_of_part_numbers_for_line(previous_line, current_line, next_line)

      # Cycle the lines
      previous_line = current_line
      current_line = next_line
    end

    # Do the last line
    next_line = '.' * current_line.length
    sum_of_part_numbers += sum_of_part_numbers_for_line(previous_line, current_line, next_line)

  end

  puts "Sum of part numbers: #{sum_of_part_numbers}"
else
  puts "File not found: #{filename}"
end

