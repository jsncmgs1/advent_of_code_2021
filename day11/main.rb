def octoflash
  octos = []
  File.open("input.txt").each_line do |line|
    octos << line.strip.split("").map(&:to_i)
  end

  pulses = 0
  width = octos.first.count
  height = octos.count

  100.times do
    pulsing = []
    pulsed = {}

    increment = ->(r, c){
      octos[r][c] += 1
    }

    pulse = ->(row, col){
      return if pulsed["#{row},#{col}"]
      pulses += 1
      pulsed["#{row},#{col}"] = true
      might_pulse = []
      might_pulse << [row, col + 1] if col < width - 1
      might_pulse << [row, col - 1] if col != 0
      might_pulse << [row - 1, col - 1] if col != 0 && row != 0
      might_pulse << [row - 1, col] if row != 0
      might_pulse << [row - 1, col + 1] if col < width -1 && row != 0
      might_pulse << [row + 1, col - 1] if col != 0 && row < height - 1
      might_pulse << [row + 1, col] if row < height - 1
      might_pulse << [row + 1, col + 1] if col < width - 1 && row < height -1

      might_pulse.each do |r,c|
        if increment.call(r,c) > 9
          pulse.call(r, c)
        end
      end
    }

    octos.each_with_index do |row, ridx|
      row.each_with_index do |col, cidx|
        octos[ridx][cidx] += 1

        if octos[ridx][cidx] > 9
          pulsing << [ridx,cidx]
        end
      end
    end

    pulsing.each do |r,c|
      pulse.call(r,c)
    end

    pulsed.keys.each do |k|
      r,c = k.split(",").map(&:to_i)
      octos[r][c] = 0
    end
  end

  pulses
end

puts octoflash
