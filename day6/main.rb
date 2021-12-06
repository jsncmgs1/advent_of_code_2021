require 'benchmark'

def simulate_lanternfish(days)
  input = File.read("input.txt").gsub(/\n/, "").split(",")

  fish_count = 0
  spawn_table = {
    "0" => 0,
    "1" => 0,
    "2" => 0,
    "3" => 0,
    "4" => 0,
    "5" => 0,
    "6" => 0,
    "7" => 0,
    "8" => 0
  }

  input.each do |n|
    fish_count += 1
    spawn_table[n] += 1
  end

  puts Benchmark.measure {
    days.times do
      new_or_recently_duplicated = spawn_table["0"]
      fish_count += new_or_recently_duplicated

      spawn_table["0"] = spawn_table["1"]
      spawn_table["1"] = spawn_table["2"]
      spawn_table["2"] = spawn_table["3"]
      spawn_table["3"] = spawn_table["4"]
      spawn_table["4"] = spawn_table["5"]
      spawn_table["5"] = spawn_table["6"]
      spawn_table["6"] = spawn_table["7"] + new_or_recently_duplicated
      spawn_table["7"] = spawn_table["8"]
      spawn_table["8"] = new_or_recently_duplicated
    end
  }

  puts fish_count
end

simulate_lanternfish(256)
