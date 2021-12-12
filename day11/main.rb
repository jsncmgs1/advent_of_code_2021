def octoflash
  octos = []
  File.open("input.txt").each_line do |line|
    octos << line.strip.split("").map(&:to_i)
  end

  width = octos.first.count
  height = octos.count
  steps = 0
  mega_flash = false
  all_zeros = Array.new(octos.length, Array.new(octos.first.length,0))

  while !mega_flash do
    if octos == all_zeros
      mega_flash = true
      break
    end

    steps += 1
    flashing = []
    flashed = {}

    increment = ->(r, c){
      octos[r][c] += 1
    }

    flash = ->(row, col){
      return if flashed["#{row},#{col}"]
      flashed["#{row},#{col}"] = [row, col]
      might_flash = []
      might_flash << [row, col + 1] if col < width - 1
      might_flash << [row, col - 1] if col != 0
      might_flash << [row - 1, col - 1] if col != 0 && row != 0
      might_flash << [row - 1, col] if row != 0
      might_flash << [row - 1, col + 1] if col < width -1 && row != 0
      might_flash << [row + 1, col - 1] if col != 0 && row < height - 1
      might_flash << [row + 1, col] if row < height - 1
      might_flash << [row + 1, col + 1] if col < width - 1 && row < height -1

      might_flash.each do |r,c|
        if increment.call(r,c) > 9
          flash.call(r, c)
        end
      end
    }

    octos.each_with_index do |row, ridx|
      row.each_with_index do |col, cidx|
        increment.call(ridx, cidx)

        if octos[ridx][cidx] > 9
          flashing << [ridx,cidx]
        end
      end
    end

    flashing.each do |r,c|
      flash.call(r,c)
    end

    flashed.values.each do |r,c|
      octos[r][c] = 0
    end
  end

  steps
end

puts octoflash
