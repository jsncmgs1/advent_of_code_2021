def parse_input
  nums = ""
  boards = []
  board = []

  File.foreach("input.txt").with_index do |line, idx|
    if idx == 0
      nums = line.split(",")
      next
    end

    if line == "\n"
      boards << board if board.any?
      board = []
    else
      board << line.split(" ")
    end
  end

  return nums, boards
end

def bingo
  nums, boards = parse_input
  found = false
  num = nil

  while !found do
    break if nums.empty?
    num = nums.shift

    boards.each_with_index do |board, board_idx|
      board.each_with_index do |row, row_idx|
        row.each.with_index do |row_num, column_idx|
          if num == row_num
            boards[board_idx][row_idx][column_idx] = "x"
          end
        end
      end
    end

    # check bingo
    boards.each do |board|
      cols = [[],[],[],[],[]]
      board.each_with_index do |row, idx|
        if row.all? {|a| a == "x"}
          found = board
          break
        end

        row.each_with_index do |num, idx|
          cols[idx] << num
        end
      end

      cols.each do |col|
        if col.all? {|c| c == "x"}
          found = board
          break
        end
      end
    end
  end


  sum = 0
  found.each do |row|
    row.each do |col|
      if col != "x"
        sum += col.to_i
      end
    end
  end

  puts sum * num.to_i
end

bingo
