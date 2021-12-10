def height_map
  heights = []
  File.open("input.txt").each_line do |line|
    heights << line.strip.split("")
  end

  visited = {}
  basins = []
  width = heights.first.length

  not_visited = ->(r, c){ !visited["#{r},#{c}"] }

  check_neighbors = ->(r, c, basin){
    visited["#{r},#{c}"] = true

    if heights[r][c] != "9"
      basin << 1
      basin = check_neighbors.call(r + 1, c, basin) if r < heights.length - 1 && not_visited.call(r + 1, c)
      basin = check_neighbors.call(r, c + 1, basin) if c < width - 1 && not_visited.call(r, c + 1)
      basin = check_neighbors.call(r - 1, c, basin) if r != 0 && not_visited.call(r - 1, c)
      basin = check_neighbors.call(r, c - 1, basin) if c != 0  && not_visited.call(r, c - 1)
    end

    basin
  }

  heights.each_with_index do |row,row_idx|
    row.each_index do |col_idx|
      next unless not_visited.call(row_idx, col_idx)
      basins << check_neighbors.call(row_idx, col_idx, [])
    end
  end

  basins.map(&:count).sort.last(3).reduce(&:*)
end

puts height_map
