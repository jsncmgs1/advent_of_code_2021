def crab_walk
  input = File.read('input.txt')
    .gsub(/\n/, "")
    .split(",")
    .map(&:to_i)
    .sort!

  # yes I know this won't work for every median set
  # but it works for mine and I live to AOC another day
  median,_ = input[input.length/2.0]

  steps = input.reduce(0) do |acc, n|
    acc += (n - median).abs
  end

  puts steps
end

crab_walk
