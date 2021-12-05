def find_vents
  field = Hash.new(0)

  File.open("input.txt").each_line do |line|
    x1, y1, x2, y2 = line.scan(/\d+/).map(&:to_i)
    is_diagonal = ((x1 - x2).abs == (y1 - y2).abs)

    next unless (x1 == x2 || y1 == y2 || is_diagonal)

    if is_diagonal
      field["#{x2},#{y2}"] += 1

      while "#{x1},#{y1}" != "#{x2},#{y2}" do
        field["#{x1},#{y1}"] += 1
        x1 < x2 ? x1 += 1 : x1 -= 1
        y1 < y2 ? y1 += 1 : y1 -= 1
      end
    elsif x1 == x2
      ([y1, y2].min..[y1, y2].max).each do |y|
        field["#{x1},#{y}"] += 1
      end
    else
      ([x1, x2].min..[x1, x2].max).each do |x|
        field["#{x},#{y1}"] += 1
      end
    end
  end

  puts field.values.count {|x| x > 1}
end

find_vents

