def parse_input
  instructions = []
  marks = {x: [], y: []}

  y_max = 0
  x_max = 0
  File.open("input.txt").each_line do |line|
    next if line == "\n"

    if line.match?(/\d+,\d+/)
      x, y = line.split(",").map(&:to_i)
      marks[:x] << x
      marks[:y] << y
      y_max = y if y_max < y
      x_max = x if x_max < x
    else
      instructions << line.scan(/[xy]=\d+/).first.split("=")
    end
  end

  sheet = Array.new(y_max + 1) { Array.new(x_max + 1, ".") }

  marks[:x].zip(marks[:y]).each do |x, y|
    sheet[y][x] = "#"
  end

  [sheet, instructions]
end

def origami
  sheet, instructions = parse_input
  sheet << Array.new(sheet.first.length) if sheet.first.length.odd?

  instructions.each do |axis,line|
    new_row = []
    new_sheet = []

    if axis == "y"
      sheet.delete_at(line.to_i)

      sheet[0...line.to_i].each_with_index do |row,idx|
        new_row = []

        row.each_with_index do |col, cidx|
          top = col
          bottom = sheet[-(idx + 1)][cidx]
          new_row << ([top,bottom].include?("#") ? "#" : ".")
        end

        new_sheet << new_row
      end
    else
      sheet.each do |row|
        new_row = []
        row.delete_at(line.to_i)

        row[0...line.to_i].each_with_index do |col, idx|
          left = col
          right = row[-(idx + 1)]

          next if [left,right].include?(nil)
          new_row << ([left,right].include?("#") ? "#" : ".")
        end

        new_sheet << new_row
      end
    end

    sheet = new_sheet
  end

  sheet.each do |row|
    puts row.join("")
  end
end
origami
