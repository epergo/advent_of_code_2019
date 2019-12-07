def fuel_required(mass : Int32) : Int32
  (mass.to_i / 3).floor.to_i - 2
end

mass_inputs = File.new("./input1.txt").gets_to_end.split("\n").reject { |string| string.empty? }.map { |mass| mass.to_i }

total_fuel = mass_inputs.sum do |mass|
  fuel = fuel_required(mass)
  total = 0

  while fuel > 0
    total += fuel
    fuel = fuel_required(fuel)
  end

  total
end

puts total_fuel
