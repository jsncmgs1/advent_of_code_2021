def sonarSweep(input, priorSum, increased)
  return increased if input.length < 3
  currentSum = input[0..2].reduce(:+)
  increased += 1 if currentSum > priorSum && priorSum != 0
  sonarSweep(input[1..], currentSum, increased)
end
