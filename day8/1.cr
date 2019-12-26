def verify(input : String, width : Int32, height : Int32) : Int32
  row_counter = 0
  min_zeros = nil
  result = 0
  layer = [] of Int32

  input.split("").each_slice(width) do |row|
    if row_counter < height
      row_counter += 1
    else
      row_counter = 1
      zeros = layer.count(0)
      if min_zeros.nil? || zeros < min_zeros
        result = layer.count(1) * layer.count(2)
        min_zeros = zeros
      end

      layer = [] of Int32 # New layer, reset
    end
    layer.concat(row.map(&.to_i))
  end

  # Add the last layer
  layer.count(0) < min_zeros.not_nil! ? layer.count(1) * layer.count(2) : result
end
