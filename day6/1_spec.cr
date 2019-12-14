require "spec"
require "./1.cr"

describe "Day6" do
  it "sample configuration" do
    data = <<-OBJECTS.split("\n").reject(&.empty?)
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    OBJECTS

    total_orbits(data).should eq(42)
  end

  it "input" do
    data = File.new("./input.txt")
      .gets_to_end
      .split("\n")
      .reject(&.empty?)

    total_orbits(data).should eq(223251)
  end
end
