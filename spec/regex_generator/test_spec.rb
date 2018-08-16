RSpec.describe RegexGenerator::Test do
  it "can pass tests" do
    test1 = RegexGenerator::Test.new('a')

    expect(test1.passes?(/a/)).to be true
  end

  it "can fail tests" do
    test2 = RegexGenerator::Test.new('a', false)
    expect(test2.passes?(/b/)).to be true
  end
end
