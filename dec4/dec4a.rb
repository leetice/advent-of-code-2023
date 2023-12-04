
filename = 'input.txt'

# Check if the file exists
if File.exist?(filename)
  total_card_points = 0

  # Open the file
  File.open(filename, 'r') do |file|

    # Read each line in the file
    file.each_line do |line|
      line.chomp!

      # Splitting the string
      winning_part, card_part = line.split('|').map(&:strip)
      winning_part = winning_part.split(':').last.strip

      # Extracting numbers and converting to integers
      winning_numbers = winning_part.scan(/\d+/).map(&:to_i).sort
      card_numbers = card_part.scan(/\d+/).map(&:to_i).sort

      # Finding the intersection (common elements) and its size
      matches = winning_numbers & card_numbers
      num_matches = matches.size
      total_card_points += (2 ** (num_matches-1)) if num_matches > 0
    end
  end

  puts "Total card points: #{total_card_points}"
else
  puts "File not found: #{filename}"
end

