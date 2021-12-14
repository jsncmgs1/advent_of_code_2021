def parse_input
  marks = {x: [], y: []}
  instructions = []

  File.open("input.txt").each_line do |line|
    next if line == "\n"

    if line.match?(/\d+,\d+/)
      x, y = line.split(",").map(&:to_i)
      marks[:x] << x
      marks[:y] << y
    else
      instructions << line.scan(/[xy]=\d+/).first.split("=")
      break
    end
  end

  y_length = marks[:y].max + 1
  x_length = marks[:x].max + 1
  sheet = Array.new(y_length) { Array.new(x_length, ".") }

  marks[:x].zip(marks[:y]).each do |x, y|
    sheet[y][x] = "#"
  end

  [sheet, instructions]
end

def origami
  sheet, instructions = parse_input
  new_sheet = []

  instructions.each do |axis,line|
    line = line.to_i

    if axis == "y"
      top = sheet[0..line-1]
      bottom = sheet[line+1..]

      while top.any? && bottom.any? do
        new_row = []
        tt = top.shift
        bb = bottom.pop

        tt.zip(bb).each do |a,b|
          if a == "." && b == "."
            new_row << "."
          else
            new_row << "#"
          end
        end
        new_sheet << new_row
      end
    else
      new_sheet = new_sheet.any? ? new_sheet : sheet

      left = new_sheet.map {|row| row[0..line-1]}
      right = new_sheet.map {|row| row[line+1..]}

      curr_row = 0
      while left.any? && right.any? do
        new_row = []
        ll = left.shift
        rr = right.shift

        while ll.any? do
          lll = ll.shift
          rrr = rr.pop

          if lll == "." && rrr == "."
            new_row << "."
          else
            new_row << "#"
          end
        end
        new_sheet[curr_row] = new_row
        curr_row+=1
      end
    end
  end

  count = 0

  new_sheet.each do |row|
    row.each do |col|
      count += 1 if col == "#"
    end
  end

  count
end


puts origami
