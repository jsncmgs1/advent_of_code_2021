def dive
  depth, forward, aim = 0, 0, 0

  input.each do |nav|
    direction, amount = nav.split(" ")
    amount = amount.to_i

    case direction
    when "forward"
      forward += amount
      depth += aim * amount unless aim.zero?
    when "up" then aim -= amount
    when "down" then aim += amount
    end
  end

  puts depth * forward
end
