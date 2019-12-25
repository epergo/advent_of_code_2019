class IntcodeComputer
  @program : String
  @instructions : Array(Int32)
  @index : Int32
  @input_index : Int32

  # Stores the LAST output of the computer
  getter output : Int32

  getter? halted : Bool

  def initialize(@program : String)
    @instructions = @program.split(",").map(&.to_i)
    @index = 0
    @input_index = -0
    @output = -1
    @halted = false
  end

  def process_until_halt(inputs : Array(Int32)) : Int32
    result = -1
    while !@halted
      last_output = process(inputs)
      result = last_output if result == -1
    end
    result
  end

  def process(inputs : Array(Int32)) : Int32
    while @index < @instructions.size && !@halted
      op, first_pm, second_pm, third_pm = read_operation_at(@index)

      # OPs 1 and 2 will receive 3 input values
      # 3 and 4 will receive just 1
      case op
      when "01", "02"
        num1 = first_pm == "0" ? @instructions[@instructions[@index + 1]] : @instructions[@index + 1]
        num2 = second_pm == "0" ? @instructions[@instructions[@index + 2]] : @instructions[@index + 2]

        if op == "01"
          @instructions[@instructions[@index + 3]] = num1 + num2
        else
          @instructions[@instructions[@index + 3]] = num1 * num2
        end

        @index += 4
      when "03", "04"
        num1 = first_pm == "0" ? @instructions[@instructions[@index + 1]] : @instructions[@index + 1]

        if op == "03"
          @instructions[@instructions[@index + 1]] = read_next_input(inputs)
        else
          @index += 2
          @output = num1
          return num1
        end

        @index += 2
      when "05", "06"
        num1 = first_pm == "0" ? @instructions[@instructions[@index + 1]] : @instructions[@index + 1]
        num2 = second_pm == "0" ? @instructions[@instructions[@index + 2]] : @instructions[@index + 2]

        if op == "05"
          if num1 != 0
            @index = num2
          else
            @index += 3
          end
        elsif op == "06"
          if num1 == 0
            @index = num2
          else
            @index += 3
          end
        end
      when "07", "08"
        num1 = first_pm == "0" ? @instructions[@instructions[@index + 1]] : @instructions[@index + 1]
        num2 = second_pm == "0" ? @instructions[@instructions[@index + 2]] : @instructions[@index + 2]

        if op == "07"
          if num1 < num2
            @instructions[@instructions[@index + 3]] = 1
          else
            @instructions[@instructions[@index + 3]] = 0
          end
        elsif op == "08"
          if num1 == num2
            @instructions[@instructions[@index + 3]] = 1
          else
            @instructions[@instructions[@index + 3]] = 0
          end
        end

        @index += 4
      else
        halt!
      end
    end

    @output
  end

  private def read_operation_at(index : Int32) : Array(String)
    # full_op contains:
    # - Operation to execute [1, 2, 3, 4]
    # - Parameter mode for inputs and ouput, can be either positional or immediate
    full_op = @instructions[index].to_s.rjust(5, '0')

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

  private def halt!
    @halted = true
  end

  private def read_next_input(inputs : Array(Int32)) : Int32
    input = inputs[@input_index]
    @input_index += 1

    input
  end
end
