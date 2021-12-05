def parse_input
  field = Hash.new(0)
  File.open("input.txt").each_line do |line|
    x1, y1, x2, y2 = line.scan /\d+/

    next unless (x1 == x2 || y1 == y2)

    x1 = x1.to_i
    x2 = x2.to_i
    y1 = y1.to_i
    y2 = y2.to_i

    if x1 == x2
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

parse_input

