def crab_walk
  input = File.read('input.txt').gsub(/\n/, "").split(",").map(&:to_i)

  avg = (input.sum / input.length.to_f)
  ceil = avg.ceil
  floor = avg.floor

  calculate_steps = ->(avg){
    input.reduce(0) do |acc, n|
      num_steps = (n - avg).abs
      step_gas_usage = (num_steps*(num_steps+1))/2 # sum of all nums 1..n =  (n*(n+1))/2
      acc += step_gas_usage
    end
  }

  with_ceil = calculate_steps.call(ceil)
  with_floor = calculate_steps.call(floor)

  puts [with_ceil, with_floor].min
end

crab_walk
