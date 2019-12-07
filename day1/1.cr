puts File
  .new("./input1.txt")
  .gets_to_end
  .split("\n")
  .reject { |string| string.empty? }
  .sum { |mass| (mass.to_i / 3).floor.to_i - 2 }
