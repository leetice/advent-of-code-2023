
filename = 'input.txt'

def adjacent_numbers(line, index)
  pattern = /\d+/

  indexes = []
  numbers = []

  line[index-1..index+1].enum_for(:scan, pattern).each do
    match = Regexp.last_match
    indexes << (index - 1 + match.begin(0))
  end

  # if we have a match, extract the number
  if (indexes.count)
    line.enum_for(:scan, pattern).each do |match|
      match_data = Regexp.last_match
      start_index = match_data.begin(0)
      end_index = match_data.end(0) - 1

      indexes.each do |i|
        if i.between?(start_index, end_index)
          numbers << match_data[0]
          break
        end
      end
    end
  end

  numbers
end

def sum_of_part_numbers_for_line(previous_line, current_line, next_line)
  sum = 0

  # Regular expression to match a sequence of digits
  gear_pattern = /\*/

  # Enumerate over each match with its index
  current_line.enum_for(:scan, gear_pattern).each do
    match = Regexp.last_match
    index = match.begin(0)

    numbers = adjacent_numbers(previous_line, index) + adjacent_numbers(current_line, index) + adjacent_numbers(next_line, index)

    puts "Numbers: #{numbers}"

    if numbers.count == 2
      sum += numbers[0].to_i * numbers[1].to_i
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

