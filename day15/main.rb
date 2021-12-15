def chitons
  cave = []; File.open('input.txt').each_line do |line|
    cave << line.strip.split("").map(&method(:Integer))
  end

  paths = []
  # seed the path across and down so we can backtrack efficiently
  high_risk = cave.first.reduce(:+) + cave.reduce(0) {|acc,r| acc += r.last} - 1
  puts high_risk
  paths << high_risk

  find_path = ->(risk, row, col, cave, start=false){
    risk += cave[row][col] unless start

    if cave[row + 1] == nil && cave[col + 1] == nil
      if risk > high_risk
        high_risk = risk
      end
      paths << risk
      return
    end

    return if risk >= high_risk && high_risk > 0

    find_path.call(risk, row + 1, col) if row + 1 < cave.length
    find_path.call(risk, row, col + 1) if col + 1 < cave.first.length
  }


  find_path.call(0, 0, 0, cave, true)
  puts paths.min
end

chitons
