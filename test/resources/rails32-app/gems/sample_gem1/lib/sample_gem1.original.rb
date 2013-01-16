require "sample_gem1/version"
require "sample_gem1/base"

module SampleGem1
  def self.message
    "original"
  end

  def self.test_message
    base = Base.new
    "local-gem: top-level:#{self.message}, sub-level:#{base.message}"
  end
end
