class RegexGenerator::Base
  attr_accessor :true_test_casses, :false_test_casses, :allowed_regex_chars, :allowed_regex_symbols, :max_length
  attr_reader :final_result, :randomizer #,  :top_results


  def initialize(setup_hash = {})
    @regex_chars = ['^', '|']
    @regex_symbols = ['\.', '\?', '\*', '\+', '\(', '\)', '@', '\|']
    @regex_quantifiers = ['+', '*', '?']
    @regex_ranges = [ '\d', '\w', '\s', '\D', '\W', '\S',  '.']
    # @regex_pairs = [['{', '}'], ['[', ']'], ['(', ')'], ]
    # @regex_look_around = [['(?=', ')'], ['(?!', ')'], ['(?<=', ')'], ['(?<!', ')']]

    @randomizer = Random.new
    
    @max_length = setup_hash[:max_length] || 8
    @true_test_casses = setup_hash[:true_test_casses] || []
    @false_test_casses = setup_hash[:false_test_casses] || []
  end

  def random_regex_unit
    char = [
      ('a'..'z').to_a.sample,
      ('A'..'Z').to_a.sample, 
      ('0'..'9').to_a.sample,
      regex_chars.sample,
      regex_symbols.sample,
      # regex_quantifiers.sample,
      regex_ranges.sample#,
      # regex_look_around.sample
    ].sample + self.quantifier
  end
  
  def random_regex(length = randomizer.rand(1..max_length))

    begin
      Regexp.new(length.times.collect{random_regex_unit}.join)
    rescue
      random_regex(length)
    end
  end

  def passes_tests(regex)
    true_test_casses.all? { |test_case| test_case =~ regex} &&
    false_test_casses.none? { |test_case| test_case =~ regex}
  end

  def solved?
    !!final_result
  end

  def number_with_delimiter(number)
    number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end

  def generate
    count = 0
    start_time = Time.now

    while !solved?
      regex = random_regex
      count += 1
      itiration_start_time = Time.now
      if passes_tests(regex)
        final_result = regex.to_s

        print "Regex: #{regex},#{' ' * (max_length*2 - regex.to_s.length)}  "
        print "try: #{number_with_delimiter(count)},  "
        print "Time: #{Time.now - itiration_start_time},  "
        puts "total time: #{(Time.now - start_time)}"

        return "done"
      else
        # if count % 1000 == 0
          print "Regex: #{regex},#{' ' * (max_length * 2 + 10 - regex.to_s.length)}  "
          print "try: #{number_with_delimiter(count)},  "
          print "Time: #{Time.now - itiration_start_time},  "
          puts "total time: #{(Time.now - start_time)}"
        # end
      end
    end
  end
end
