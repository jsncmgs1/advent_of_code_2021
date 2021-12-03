def diagnostic
  otwo = find_stats(input) do |ones, zeros|
    if ones.length == zeros.length
      ones
    else
      ones.length > zeros.length ? ones : zeros
    end
  end

  co = find_stats(input) do |ones, zeros|
    if ones.length == zeros.length
      zeros
    else
      ones.length > zeros.length ? zeros : ones
    end
  end

  otwo * co
end

def find_stats(input, pointer = 0, &block)
  return input.first.to_i(2) if input.length == 1

  ones, zeros = [], []

  input.each do |bin|
    ones << bin if bin[pointer] == "1"
    zeros << bin if bin[pointer] == "0"
  end

  input = yield ones, zeros
  find_stats(input, pointer + 1, &block)
end
