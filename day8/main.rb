require 'set'
def segment_search
  num = 0

  File.open('input.txt').each_line do |line|
    signals = line.split("|")
    num += analyze_line(signals)
  end

  puts num
end

def analyze_line(line)
  segments, values = line
  segments = segments.split(" ").sort { |x,y| x.length <=> y.length } # we want to find 1 right away so we can establish the right side segments
  right_side, left_side = Set.new, Set.new
  eight = Set.new(%w[a b c d e f g])            # since we know 8 uses all the segments, we can use that as a baseline
  codes = {}

  while codes.length < 10 do                    # loop through the list until we've pulled together enough info to find segments 0-9
    segments.each do |l|
      new_set = Set.new(l.split(""))
      case l.length
      when 2
        right_side = new_set                    # we know 1 is just the right 2 segments, so create a set for it
        codes[1] = new_set
      when 3
        codes[7] = new_set
      when 4
        codes[4] = new_set
      when 5
        if (new_set - right_side).count == 3    # a 3 has 3 segments if you remove the right side (this is unique to 3 within 5 segment numbers)
          codes[3] = new_set
          left_side = eight - new_set           # 3 doesn't contain any left side, so we can compared that to 8 to find the left_side segments
        else
          if(new_set - codes[4]).count == 3     # same type of comparisions that we did for 3
            codes[2] = new_set
          else
            codes[5] = new_set
          end
        end
      when 6                                    # more of the same types of comparisons
        if (right_side - new_set).count == 0 && (left_side - new_set).count == 0
          codes[0] = new_set
        elsif (right_side - new_set).count == 1
          codes[6] = new_set
        else
          codes[9] = new_set
        end
      when 7
        codes[8] = new_set
      end
    end
  end

  inverted = codes.invert

  num = ""
  values.split(" ").each do |x|
    y = Set.new(x.split(""))
    num += inverted[y].to_s
  end
  num.to_i
end

puts segment_search


