def syntax_scoring
  scoring = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }

  closers = {
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }
  openers = closers.invert

  routes = []
  File.open("input.txt").each_line do |line|
    routes << line.strip.split("")
  end

  incompletions = []

  routes.each do |brackets|
    stack = []
    brackets.each_with_index do |b,i|
      if openers[b]
        stack << b
      elsif stack.pop != closers[b] # corrupted
        break
      end

      if stack.any? && i == brackets.length - 1
        finisher = []
        while stack.any? do
          finisher << scoring[openers[stack.pop]]
        end

        incompletions << finisher
      end
    end
  end

  incompletions.map! do |closing_scores|
    closing_scores.reduce(0) do |acc, n|
      acc * 5 + n
    end
  end.sort!

  incompletions[(incompletions.length / 2.0).floor]
end

puts syntax_scoring
