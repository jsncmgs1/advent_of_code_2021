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
  segments = segments.split(" ").sort { |x,y| x.length <=> y.length }
  right_side, left_side = Set.new, Set.new
  eight = Set.new(%w[a b c d e f g])
  codes = {}

  while codes.length < 10 do
    segments.each do |l|
      new_set = Set.new(l.split(""))
      case l.length
      when 2
        right_side = new_set
        codes[1] ||= new_set
      when 3
        top ||= (right_side - Set.new(new_set)).first
        codes[7] = new_set
      when 4
        codes[4] = new_set
      when 5
        if (new_set - right_side).count == 3
          codes[3] = new_set
          left_side = eight - new_set
        else
          if(new_set - codes[4]).count == 3
            codes[2] = new_set
          else
            codes[5] = new_set
          end
        end
      when 6
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


