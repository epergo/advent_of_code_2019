require "spec"
require "./2.cr"

describe "Day4" do
  it "example 1" do
    input = "112233"
    valid?(input).should eq(true)
  end

  it "example 2" do
    input = "123444"
    valid?(input).should eq(false)
  end

  it "example 3" do
    input = "111122"
    valid?(input).should eq(true)
  end
end

