require "./intcode_computer.cr"

def max_thruster(program : String) : Int32
  max = -1
  0.to(4) do |inputA|
    0.to(4) do |inputB|
      0.to(4) do |inputC|
        0.to(4) do |inputD|
          0.to(4) do |inputE|
            next unless [inputA, inputB, inputC, inputD, inputE].uniq.size == 5

            resultA  = IntcodeComputer.new(program).process([inputA, 0])
            resultB  = IntcodeComputer.new(program).process([inputB, resultA])
            resultC  = IntcodeComputer.new(program).process([inputC, resultB])
            resultD  = IntcodeComputer.new(program).process([inputD, resultC])
            thruster = IntcodeComputer.new(program).process([inputE, resultD])

            max = thruster if thruster > max
          end
        end
      end
    end
  end

  max
end
