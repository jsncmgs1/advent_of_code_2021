def crab_walk
  input = File.read('input.txt').gsub(/\n/, "").split(",").map(&:to_i)
  avg = (input.sum / input.length.to_f)

  calculate_steps = ->(avg){
    input.reduce(0) do |acc, n|
      num_steps = (n - avg).abs
      step_gas_usage = (num_steps * (num_steps + 1))/2 # sum of all nums 1..n =  (n*(n+1))/2
      acc += step_gas_usage
    end
  }

  puts [calculate_steps.call(avg.ceil), calculate_steps.call(avg.floor)].min
end

crab_walk
