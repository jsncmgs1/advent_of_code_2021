def parse_input
  rules = {}
  opener = ""

  File.open("input.txt").each_line do |line|
    next if line == "\n"

    if line.match?(/->/)
      pair, tweener = line.split(/ -> /)
      rules[pair] = tweener.strip
    else
      opener = line.strip
    end
  end

  [rules, opener]
end

def polymers
  rules, opener = parse_input
  counts = Hash.new(0)

  opener.split("").each_with_index do |poly, idx|
    break if idx + 1 == opener.length
    counts[poly+opener[idx+1]] += 1
  end

  40.times do
    new_counts = Hash.new(0)

    counts.each do |k,v|
      new = rules[k]
      l, r = k.split("")
      new_counts["#{l}#{new}"] += v
      new_counts["#{new}#{r}"] += v
    end

    counts = new_counts
  end

  totals = Hash.new(0)

  counts.each do |k,v|
    l, r = k.split("")
    totals[l] += v
    totals[r] += v
  end

  totals = totals.map do |k,v|
    v += 1 if v.odd?  # we miscounted if it's odd. dont judge me
    v/2               # handle counting duplicates
  end

  puts totals.max - totals.min
end

puts polymers
