program = File.new("./input1.txt").gets_to_end.split(",").reject { |string| string.empty? }.map { |op| op.to_i }

def program_output(p : Array(Int32), noun : Int32, verb : Int32) : Array(Int32)
  p[1] = noun
  p[2] = verb

  i = 0
  while i < p.size
    op = p[i]
    if op == 99
      break
    end

    num1 = p[p[i + 1]]
    num2 = p[p[i + 2]]

    p[p[i + 3]] = op == 1 ? num1 + num2 : num1 * num2

    i += 4
  end

  p
end

found = false
output : Array(Int32)
0.to(99) do |noun|
  break if found
  0.to(99) do |verb|
    output = program_output(program.dup, noun, verb)
    if output[0] == 19690720
      found = true

      # Print solution
      puts 100 * noun + verb
      break
    end
  end
end
