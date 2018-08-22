RSpec.describe RegexGenerator do

  it "has a version number" do
    expect(RegexGenerator::VERSION).not_to be nil
  end

  it "can build 10.000 1-10 charactor regular expressions in under a second" do
    starting_time = Time.now

    RegexGenerator.max_length = 10
    builds = 10_000.times.collect do
      RegexGenerator.build
    end

    expect(Time.now - starting_time).to be < 1
  end

  it "works with the simplest case" do
    RegexGenerator.add_tests(
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
    expect RegexGenerator.run
  end

  it "and can be optimized" do
    RegexGenerator.add_tests(
      [
        ['4', true],
        ['8', true],
        ['3', true],
        ['1', true],
        ['a', false],
        ['/', false],
        ['y', false],
        ['s', false]
      ]
    )
    RegexGenerator.run
    expect RegexGenerator.optimize(6000)
  end

  it "works in a more complex case" do
    RegexGenerator.add_tests(
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
    RegexGenerator.run
    expect RegexGenerator.optimize(20000)
  end

end
