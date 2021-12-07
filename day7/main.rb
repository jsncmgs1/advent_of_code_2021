def crab_walk
  input = File.read('input.txt').gsub(/\n/, "").split(",").map(&:to_i)
  require 'pry'; binding.pry


end

def medians(sorted_array)
  return nil if array.empty?
  len = array.length

  if len.odd?
    return array[(array/2.0).ceil]
  else
    return
  end
end

crab_walk
