namespace :test do
  namespace :data do
    desc "Reset the codebase"
    task :reset do
      overwrite_codes_with!(:original)
    end

    desc "Modify the codebase"
    task :modify do
      overwrite_codes_with!(:modified)
    end

    def overwrite_codes_with!(type)
      require "fileutils"
      {
        "gems/sample_gem1/lib/sample_gem1.#{type}.rb" => "gems/sample_gem1/lib/sample_gem1.rb",
        "gems/sample_gem1/lib/sample_gem1/base.#{type}.rb" => "gems/sample_gem1/lib/sample_gem1/base.rb"
      }.each do |from, to|
        FileUtils.cp from, to
      end
    end
  end
end
