require "./intcode_computer.cr"

def max_thruster(program : String) : Int32
  max = -1
  5.to(9) do |phaseA|
    5.to(9) do |phaseB|
      5.to(9) do |phaseC|
        5.to(9) do |phaseD|
          5.to(9) do |phaseE|
            next unless [phaseA, phaseB, phaseC, phaseD, phaseE].uniq.size == 5

            computerA = IntcodeComputer.new(program)
            computerB = IntcodeComputer.new(program)
            computerC = IntcodeComputer.new(program)
            computerD = IntcodeComputer.new(program)
            computerE = IntcodeComputer.new(program)

            resultA, resultB, resultC, resultD, resultE = [0, 0, 0, 0, 0]
            inputsA = [phaseA]
            inputsB = [phaseB]
            inputsC = [phaseC]
            inputsD = [phaseD]
            inputsE = [phaseE]
            while true
              resultA = computerA.process(inputsA.push(resultE))
              resultB = computerB.process(inputsB.push(resultA))
              resultC = computerC.process(inputsC.push(resultB))
              resultD = computerD.process(inputsD.push(resultC))
              resultE = computerE.process(inputsE.push(resultD))
              break if computerE.halted?
            end

            max = resultE if resultE > max
          end
        end
      end
    end
  end

  max
end
