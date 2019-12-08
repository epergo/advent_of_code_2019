def valid?(password : String) : Bool
  # length
  password.size == 6 &&
    # always increasing
    password == password.split("").sort.join("") &&
    # double
    password.split("").map(&.to_i).group_by { |c| c }.count { |key, values| values.size == 2 } > 0
end


result = [] of Int32
172930.to(683082) do |number|
  result.push(number) if valid?(number.to_s)
end

puts result.size

