def closest_intersection(wires) : Int32
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

  (coordinates[0] & coordinates[1]) # Obtain intersections
    .min_by { |coordinate| coordinate[0].abs + coordinate[1].abs }
    .map { |num| num.abs }
    .sum
end

puts closest_intersection(
  File.new("./input1.txt").gets_to_end.split("\n")
)
