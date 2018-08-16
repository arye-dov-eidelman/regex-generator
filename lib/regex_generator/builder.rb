class RegexGenerator::Builder
  @@all_chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~".split('')
  # @@all_chars.combination(3).to_a

  def self.build(length = @length || rand(1..4))
    @length = length
    random_regex
  end

  private

  def self.random_charactor
    @@all_chars.sample
  end

  def self.random_string
    @length.times.collect{random_charactor}.join
  end
 
  def self.random_regex
    begin
      Regexp.new(random_string)
    rescue
      random_regex
    end
  end
end
