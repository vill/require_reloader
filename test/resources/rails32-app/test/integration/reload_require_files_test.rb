require 'test_helper'

class ReloadRequireFilesTest < ActionDispatch::IntegrationTest

   self.use_transactional_fixtures = false
   
   test "the truth" do
     overwrite_codes_with!(:original)

     get "/test.txt"
     assert_equal  [
       "local-gem: top-level:original, sub-level:original",
       "lib: top-level:original, sub-level:original"
     ].join("\n"), @response.body, "before modify codebase"

     overwrite_codes_with!(:modified)

     get "/test.txt"
     assert_equal  [
       "local-gem: top-level:modified, sub-level:modified",
       "lib: top-level:modified, sub-level:modified"
     ].join("\n"), @response.body, "after modify codebase"

     overwrite_codes_with!(:original)
   end

   def overwrite_codes_with!(type)
     require "fileutils"
     {
       "gems/sample_gem1/lib/sample_gem1.#{type}.rb" => "gems/sample_gem1/lib/sample_gem1.rb",
       "gems/sample_gem1/lib/sample_gem1/base.#{type}.rb" => "gems/sample_gem1/lib/sample_gem1/base.rb",
       "lib/sample_gem2.#{type}.rb" => "lib/sample_gem2.rb",
       "lib/sample_gem2/base.#{type}.rb" => "lib/sample_gem2/base.rb"
     }.each do |from, to|
       FileUtils.cp from, to
     end
     sleep 0.5
   end
end
