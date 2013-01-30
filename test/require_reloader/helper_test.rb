require 'minitest/autorun'
require 'require_reloader/helper'

describe RequireReloader::Helper do

  it "converts gem name to class name based on RubyGem Consistent Naming" do
    c = RequireReloader::Helper.new
    c.full_qualified_name(
      "foo_bar_baz-bibi_baba-roo").must_equal "FooBarBaz::BibiBaba::Roo"
  end

  it "handles different permutations of gem name pattern" do
    SAMPLES = {
      nil => nil,
      ""  => "",
      "haml-rails" => "Haml::Rails",
      "module1" => "Module1",
      "foo_bar" => "FooBar",
      "foo_bar_baz-bibi_baba-roo" => "FooBarBaz::BibiBaba::Roo"
    }
    c = RequireReloader::Helper.new

    SAMPLES.each do |gem_name, class_name|
      c.full_qualified_name(gem_name).must_equal(
        class_name, "gem_name: #{gem_name.inspect}")
    end
  end
end
