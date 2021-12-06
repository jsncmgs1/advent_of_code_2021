require 'benchmark'

def simulate_lanternfish(days)
  input = File.read("input.txt").gsub(/\n/, "").split(",").map(&:to_i)

  fish_count = 0
  spawn_table = Array.new(9, 0)
  input.each do |n|
    fish_count += 1
    spawn_table[n] += 1
  end

  days.times do
    new_or_recently_duplicated = spawn_table[0]
    fish_count += new_or_recently_duplicated

    spawn_table.shift
    spawn_table[6] += new_or_recently_duplicated
    spawn_table[8] = new_or_recently_duplicated
  end

  puts fish_count
end

simulate_lanternfish(256)
