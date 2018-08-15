class RegexGenerator::Score
  attr_accessor :regex

  def initialize(regex)
    regex = regex
  end

  def overall
    speed / 2 + specificity / 3 + readabilty / 6
  end

  def speed
    # benchmark speed for which examples?
    #   only the passing ones
    #   also the failing ones
    #   or add some random examples as well
  end

  def specificity
    # lose ponts for litteral charactors get points for ranges
  end

  def readabilty
    # how in the world is readability defined is it that it's shorter?
  end
end
