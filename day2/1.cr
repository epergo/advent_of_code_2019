program = File.new("./input1.txt").gets_to_end.split(",").reject { |string| string.empty? }.map { |op| op.to_i }
program[1] = 12
program[2] = 2

index = 0
while index < program.size
  op = program[index]
  if op == 99
    break
  end

  num1 = program[program[index + 1]]
  num2 = program[program[index + 2]]

  program[program[index + 3]] = op == 1 ? num1 + num2 : num1 * num2

  index += 4
end

puts program.join(", ")
