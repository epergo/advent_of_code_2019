require "spec"
require "./1.cr"

describe "Day4" do
  it "example 1" do
    input = "111111"
    valid?(input).should eq(true)
  end

  it "example 2" do
    input = "223450"
    valid?(input).should eq(false)
  end

  it "example 3" do
    input = "123789"
    valid?(input).should eq(false)
  end
end

