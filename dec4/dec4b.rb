
filename = 'input.txt'

# Check if the file exists
if File.exist?(filename)
  card_counts = Hash.new(0)

  # Open the file
  File.open(filename, 'r') do |file|
    card_num = 1

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

      # Count the original card
      num_current_cards = card_counts[card_num] += 1

      # Update card counts
      for i in card_num+1..card_num+num_matches
        card_counts[i] += num_current_cards
      end

      card_num += 1
    end
  end

  puts "Total number of cards: #{card_counts.values.sum}"
else
  puts "File not found: #{filename}"
end

