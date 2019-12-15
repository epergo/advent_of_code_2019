require "./intcode_computer.cr"

def max_thruster(program : String) : Int32
  max = -1
  computer = IntcodeComputer.new(program)
  0.to(4) do |inputA|
    0.to(4) do |inputB|
      0.to(4) do |inputC|
        0.to(4) do |inputD|
          0.to(4) do |inputE|
            next unless [inputA, inputB, inputC, inputD, inputE].uniq.size == 5

            resultA = computer.process([inputA, 0])
            resultB = computer.process([inputB, resultA])
            resultC = computer.process([inputC, resultB])
            resultD = computer.process([inputD, resultC])
            thruster = computer.process([inputE, resultD])

            max = thruster if thruster > max
          end
        end
      end
    end
  end

  max
end
