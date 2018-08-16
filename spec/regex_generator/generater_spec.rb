RSpec.describe RegexGenerator do
  it "has a version number" do
    expect(RegexGenerator::VERSION).not_to be nil
  end

  it "works with the simplest case" do
    a = RegexGenerator::Generater.new
    a.add_test_cases(
      [
        ['4', true],
        ['8', true],
        ['3', true],
        ['1', true],
        ['a', false],
        ['t', false],
        ['y', false],
        ['s', false]
      ]
    )
    expect a.find_passing_regex
  end

  it "works a more complex case" do
    a = RegexGenerator::Generater.new
    a.add_test_cases(
      [
        ['<html>', true],
        ['/><script', true],
        ['/>', true],
        ['<img>', true],
        ['>', true],
        ['<', true],
        ['html', false],
        ['script', false],
        ['img', false],
        ['', false],
        ['/', false],
        ['"', false],
        ['\'', false],
        ['^', false],
        ['g', false]
      ]
    )
    a.find_passing_regex
    expect a.solution.optimize
  end
end
