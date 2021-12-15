def chitons
  cave = []; File.open('input.txt').each_line do |line|
    cave << line.split("").map(&:to_i)
  end

  cave.each do |c|
    puts c
  end
end
chitons
