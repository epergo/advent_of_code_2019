require "spec"
require "./1.cr"

describe "Day8" do
  it "example 1" do
    verify("123456789012", 3, 2).should eq(1)
  end

  it "real input" do
    input = File.new("../input.txt")
      .gets_to_end
      .split("\n")
      .reject { |string| string.empty? }
      .join("")
    verify(input, 25, 6).should eq(1806)
  end
end
