def output(program : String, input : Int32) : Int32
  result = [] of Int32
  p = program.split(",").map(&.to_i)

  i = 0
  while i < p.size
    # full_op contains:
    # - Operation to execute [1, 2, 3, 4]
    # - Parameter mode for inputs and ouput, can be either positional or immediate
    full_op = p[i].to_s.rjust(5, '0')

    # OPs can be one of:
    # - 1 Sum two values
    # - 2 Multiply two values
    # - 3 Copy the input from one position to another
    # - 4 Output value in position
    # - 99 Terminate the program
    op = full_op[3..4]

    # OPs 1 and 2 will receive 3 input values
    # 3 and 4 will receive just 1
    case op
    when "01", "02"
      num1 = full_op[2] == '0' ? p[p[i + 1]] : p[i + 1]
      num2 = full_op[1] == '0' ? p[p[i + 2]] : p[i + 2]

      if op == "01"
        p[p[i + 3]] = num1 + num2
      else
        p[p[i + 3]] = num1 * num2
      end

      i += 4
    when "03", "04"
      num1 = full_op[2] == '0' ? p[p[i + 1]] : p[i + 1]

      if op == "03"
        p[p[i + 1]] = input
      else
        result.push(num1)
      end

      i += 2
    when "05", "06"
      num1 = full_op[2] == '0' ? p[p[i + 1]] : p[i + 1]
      num2 = full_op[1] == '0' ? p[p[i + 2]] : p[i + 2]

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
      num1 = full_op[2] == '0' ? p[p[i + 1]] : p[i + 1]
      num2 = full_op[1] == '0' ? p[p[i + 2]] : p[i + 2]

      if op == "07"
        if num1 < num2
          p[p[i + 3]] = 1
        else
          p[p[i + 3]] = 0
        end
      elsif op == "08"
        if num1 == num2
          p[p[i + 3]] = 1
        else
          p[p[i + 3]] = 0
        end
      end

      i += 4
    else
      break # 99
    end
  end

  result.last
end
