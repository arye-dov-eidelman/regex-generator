module RegexGenerator
  require 'timeout'
  require 'irb'
  require 'pry'

  $VERBOSE = nil
  VERSION = "0.1.0"
  ALL_CHARS = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~".split('')
  Test = Struct.new(:test, :should_match)
  Score = Struct.new(:speed, :length, :overall)
  Solution = Struct.new(:regex, :score)

  def self.reset
    @tests = []
    @solution = nil
    @solutions = []
    @failed_build_count = 0
    @build_count = 0
    @max_length = 10
  end
  self.reset

  class << self
    attr_accessor :failed_build_count, :build_count, :max_length
    attr_reader :solution
  end

  def self.run
    generate_solution
    puts <<~OUTPUT

    Regex:         /#{@solution.regex.source}/
    Valid builds:  #{@build_count.to_s}
    Failed builds: #{@failed_build_count.to_s}
    Overall score: #{@solution.score.overall}
    OUTPUT
    @solution
  end

  def self.generate_solution
    regex = build
    while !test(regex)
      regex = build
    end

    @solution = Solution.new(regex, score(regex))
    @solutions << @solution
    @solution
  end

  def self.score(regex)


    starting_time = Time.now
    RegexGenerator.test(regex)
    speed = (Time.now - starting_time) / @tests.length

    length = regex.source.length
    overall = speed * 1_000_000 + length
    Score.new(speed, length, overall)
  end

  def self.best_sulotion
    @solutions.min { |a, b| a.score.overall <=> b.score.overall }
  end

  def self.better_solution?(original, newer)
    !(original.score.overall >= newer.score.overall ||
      original.regex == newer.regex)
  end

  def self.optimize(seconds)
    strating_time = Time.now

    original_solution = @solution
    new_solution = self.run

    while !better_solution?(original_solution, new_solution)
      new_solution = self.run
      if Time.now.to_f > (strating_time.to_f + seconds)
        binding.pry
        puts "couldn't fint a better sulotion in #{seconds} seconds"
        exit
      end
    end

    puts "Best solution so far: #{best_sulotion.regex}"
    puts "Increased score by: #{original_solution.score.overall - best_sulotion.score.overall}"
  end

  def self.rand_string(min_length, max_length)
    rand(min_length..max_length).times.collect{ALL_CHARS.sample}.join('')
  end

  def self.build
    string = rand_string(1, @max_length)
    begin
      @build_count += 1
      Regexp.new(string)
    rescue
      @failed_build_count += 1
      build
    end
  end

  def self.test(regex)
    @tests.all? do |a_test|
      !!a_test.test.match(regex) == a_test.should_match
    end
    # why is '!!' necessary
  end

  def self.add_tests(tests_array)
    @tests += tests_array.collect do |test|
      Test.new(test[0], test[1])
    end
  end
end
