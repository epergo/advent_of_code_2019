class IntcodeComputer
  @program : String
  @instructions : Array(Int32)

  def initialize(@program : String)
    @instructions = @program.split(",").map(&.to_i)
  end

  def process(inputs : Array(Int32)) : Int32
    # We don't want to mutate the original program
    instructions = @instructions.dup
    result = -1
    inputIndex = 0

    i = 0
    while i < instructions.size
      op, first_pm, second_pm, third_pm = read_operation_at(i, instructions)

      # OPs 1 and 2 will receive 3 input values
      # 3 and 4 will receive just 1
      case op
      when "01", "02"
        num1 = first_pm == "0" ? instructions[instructions[i + 1]] : instructions[i + 1]
        num2 = second_pm == "0" ? instructions[instructions[i + 2]] : instructions[i + 2]

        if op == "01"
          instructions[instructions[i + 3]] = num1 + num2
        else
          instructions[instructions[i + 3]] = num1 * num2
        end

        i += 4
      when "03", "04"
        num1 = first_pm == "0" ? instructions[instructions[i + 1]] : instructions[i + 1]

        if op == "03"
          instructions[instructions[i + 1]] = inputs[inputIndex]
          inputIndex += 1
        else
          result = num1
        end

        i += 2
      when "05", "06"
        num1 = first_pm == "0" ? instructions[instructions[i + 1]] : instructions[i + 1]
        num2 = second_pm == "0" ? instructions[instructions[i + 2]] : instructions[i + 2]

        if op == "05"
          if num1 != 0
            i = num2
          else
            i += 3
          end
        elsif op == "06"
          if num1 == 0
            i = num2
          else
            i += 3
          end
        end
      when "07", "08"
        num1 = first_pm == "0" ? instructions[instructions[i + 1]] : instructions[i + 1]
        num2 = second_pm == "0" ? instructions[instructions[i + 2]] : instructions[i + 2]

        if op == "07"
          if num1 < num2
            instructions[instructions[i + 3]] = 1
          else
            instructions[instructions[i + 3]] = 0
          end
        elsif op == "08"
          if num1 == num2
            instructions[instructions[i + 3]] = 1
          else
            instructions[instructions[i + 3]] = 0
          end
        end

        i += 4
      else
        break
      end
    end

    result
  end

  private def read_operation_at(index : Int32, instructions : Array(Int32)) : Array(String)
    # full_op contains:
    # - Operation to execute [1, 2, 3, 4]
    # - Parameter mode for inputs and ouput, can be either positional or immediate
    full_op = instructions[index].to_s.rjust(5, '0')

    # OPs can be one of:
    # - 1 Sum two values
    # - 2 Multiply two values
    # - 3 Copy the input from one position to another
    # - 4 Output value in position
    # - 99 Terminate the program
    op = full_op[3..4]

    # Extract parameter modes for each possible operation input
    first_pm = full_op[2].to_s
    second_pm = full_op[1].to_s
    third_pm = full_op[0].to_s

    [op, first_pm, second_pm, third_pm]
  end
end
