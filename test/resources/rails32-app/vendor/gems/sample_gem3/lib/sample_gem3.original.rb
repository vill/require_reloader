require "sample_gem3/version"
require "sample_gem3/base"

module SampleGem3
  def self.message
    "original"
  end

  def self.test_message
    base = Base.new
    "vendor/gems: top-level:#{self.message}, sub-level:#{base.message}"
  end
end
