RSpec.describe RegexGenerator::Builder do

  it "can build 10.000 10 charactor regular expressions in under a second" do
    starting_time = Time.now

    builder =  RegexGenerator::Builder
    builds = 10_000.times.collect do
      builder.build(10)
    end

    expect(Time.now - starting_time).to be < 1
  end

end
