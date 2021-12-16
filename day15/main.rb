require 'set'

def chitons

  cave = []; File.open('input.txt').each_line do |line|
    cave << line.strip.split("").map(&method(:Integer))
  end

  unvisited = Set.new
  visited = Set.new
  dist = {}
  prev = {}

  cave.each_with_index do |row, ridx|
    row.each_index do |cidx|
      k = [ridx,cidx]
      unvisited << k
      dist[k] = Float::INFINITY
      prev[k] = nil
    end
  end

  dist[[0,0]] = 0

  u = [cave.length, cave.last.length]

  while unvisited.any? do
    min = nil
    unvisited.each do |node|
      if min.nil? || dist[node] < dist[min]
        min = node
      end
    end

    row, col = u = min
    neighbors = [[row+1, col], [row, col+1]]

    neighbors.each do |n|
      r,c = n
      if unvisited.include?(n)
        alt = dist[u] + cave[r][c]
        if alt < dist[n]
          dist[n] = alt
          prev[n] = [row,col]
        end
      end
    end

    unvisited.delete(min)
  end

  puts dist[[cave.length - 1, cave.last.length - 1]]
end

chitons
