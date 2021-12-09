def height_map
  heights = []
  File.open("input.txt").each_line do |line|
    width ||= line.strip.length
    heights << line.strip.split("")
  end

  risk = 0
  risks = []

  heights.each_with_index do |row, i|
    check_up = ->(n, idx){
      return true if i == 0
      n.to_i < heights[i - 1][idx].to_i
    }

    check_down = ->(n, idx){
      return true if i == (heights.length - 1)
      n.to_i < heights[i + 1][idx].to_i
    }

    check_left = ->(n, idx){
      return true if idx == 0
      n.to_i < row[idx - 1].to_i
    }

    check_right = ->(n, idx){
      return true if idx == (row.length - 1)
      n.to_i < row[idx + 1].to_i
    }

    is_lowest = ->(n, idx){
      check_up.call(n, idx) && check_down.call(n, idx) && check_left.call(n, idx) && check_right.call(n, idx)
    }

    row.each_with_index do |height, ii|
      if is_lowest.call(height, ii)
        risk += height.to_i + 1
        risks << height
      end
    end
  end

  puts risks
  puts risk
end

height_map
