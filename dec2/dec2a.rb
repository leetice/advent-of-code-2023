
filename = 'input.txt'


# Check if the file exists
if File.exist?(filename)
  # Compile the regular expression
  number_extractor = /\d+/

  max_cubes = { 'red' => 12, 'green' => 13, 'blue' => 14 }

  File.open(filename, 'r') do |file|
    sum_of_valid_game_ids = 0

    # Read each line in the file
    file.each_line do |line|
      game_invalid = false

      # Split the line into two parts using ':'
      game, details = line.split(':').map(&:strip)

      # Split the details part into segments using ';'
      details.split(';').map(&:strip).each do |set_str|
        # Split the cubes part into colors using ','
        set_str.split(',').map(&:strip).each do |cube_str|
          # Split cube_str into number and color using ' '
          number, color = cube_str.split(' ').map(&:strip)
          if number.to_i > max_cubes[color]
            game_invalid = true
            break
          end
        end
        break if game_invalid
      end

      sum_of_valid_game_ids += game[number_extractor].to_i unless game_invalid

      puts "Game: #{game[number_extractor].to_i} valid" unless game_invalid
    end

    puts "Sum of valid game IDs: #{sum_of_valid_game_ids}"
  end
else
  puts "File not found: #{filename}"
end

