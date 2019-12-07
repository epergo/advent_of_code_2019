def closest_intersection(wires)
  coordinates = [] of Array(Array(Int32))
  wires.each do |wire|
    current_coordinates = [0, 0]
    wire_path = [] of Array(Int32)
    wire
      .split(",")
      .reject { |string| string.empty? }
      .each do |step|
        r = /(\w)(\d+)/i.match(step)
        direction = r.not_nil![1]
        times = r.not_nil![2].to_i
        1.to(times) do
          case direction
          when "U" # Going Up
            current_coordinates[1] += 1
          when "R" # Going Right
            current_coordinates[0] += 1
          when "L" # Going Left
            current_coordinates[0] -= 1
          else # Going down
            current_coordinates[1] -= 1
          end
          wire_path.push(current_coordinates.dup)
        end
      end
    coordinates.push(wire_path)
  end

  [
    coordinates[0] & coordinates[1], # Intersections
    coordinates[0],
    coordinates[1],
  ]
end

def fewest_steps_for_intersection(intersections, coord1, coord2)
  result = -1
  intersections.each do |intersection|
    steps1 = coord1.index { |coordinate| coordinate[0] == intersection[0] && coordinate[1] == intersection[1] }.not_nil! + 1
    steps2 = coord2.index { |coordinate| coordinate[0] == intersection[0] && coordinate[1] == intersection[1] }.not_nil! + 1

    sum = steps1 + steps2
    result = sum if result == -1 || result > sum
  end

  result
end
