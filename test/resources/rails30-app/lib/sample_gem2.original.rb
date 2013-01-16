require "sample_gem2/base"

module SampleGem2
  def self.message
    "original"
  end

  def self.test_message
    base = Base.new
    "lib: top-level:#{self.message}, sub-level:#{base.message}"
  end
end
