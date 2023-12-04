
filename = 'input.txt'


# Check if the file exists
if File.exist?(filename)
  # Compile the regular expression
  number_extractor = /\d+/

  File.open(filename, 'r') do |file|
    sum_of_game_powers = 0

    # Read each line in the file
    file.each_line do |line|
      max_cubes = { 'red' => 0, 'green' => 0, 'blue' => 0 }

      # Split the line into two parts using ':'
      game, details = line.split(':').map(&:strip)

      # Split the details part into segments using ';'
      details.split(';').map(&:strip).each do |set_str|
        # Split the cubes part into colors using ','
        set_str.split(',').map(&:strip).each do |cube_str|
          # Split cube_str into number and color using ' '
          number, color = cube_str.split(' ').map(&:strip)
          if number.to_i > max_cubes[color]
            max_cubes[color] = number.to_i
          end
        end
      end

      game_power = max_cubes.values.inject(:*)
      sum_of_game_powers += game_power

      puts "Game #{game[number_extractor].to_i} power: #{game_power}"
    end

    puts "Sum of game powers: #{sum_of_game_powers}"
  end
else
  puts "File not found: #{filename}"
end

