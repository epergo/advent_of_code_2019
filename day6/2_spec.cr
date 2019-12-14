require "spec"
require "./2.cr"

describe "Day6" do
  it "sample configuration" do
    data = "COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L K)YOU I)SAN".split(" ").reject(&.empty?)

    orbital_transfers_between("YOU", "SAN", data).should eq(4)
  end

  it "input" do
    data = File.new("./input.txt")
      .gets_to_end
      .split("\n")
      .reject(&.empty?)

    orbital_transfers_between("YOU", "SAN", data).should eq(430)
  end
end
