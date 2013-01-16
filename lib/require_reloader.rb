require "require_reloader/version"
require "require_reloader/railtie"

module RequireReloader
  class << self

    # Reload all local gems (that is, ones which have a :path attribute)
    # automatically on each request.
    #
    # To use it, add 'RequireReloader.watch_local_gems!' to
    # your config/environments/development.rb.
    #
    def watch_local_gems!
      local_gems.each do |gem|
        # never reload itself for now, causing error raised in integration test
        next if gem[:name] == 'require_reloader'

        watch gem[:name], :path => gem[:path]
      end
    end

    # Propose to deprecate :watch_all! and reserve it for future usage.
    alias_method :watch_all!, :watch_local_gems!

    # Reload a specific gem or a gem-like .rb file
    # automatically on each request.
    #
    # In Rails 3.2+, reload happens only when a watchable file is modified.
    #
    # To use it, add 'RequireReloader.watch :my_gem' to
    # your config/environments/development.rb.
    #
    def watch(gem_name, opts={})
      gem            = gem_name.to_s
      watchable_dir  = expanded_gem_path(gem, opts[:path])
      watchable_exts = opts[:exts] ? Array(opts[:exts]) : [:rb]

      app = Object.const_get(Rails.application.class.parent_name)
      app::Application.configure do

        if watchable_dir && config.respond_to?(:watchable_dirs)
          config.watchable_dirs[watchable_dir] = watchable_exts
        end

        # based on Tim Cardenas's solution:
        # http://timcardenas.com/automatically-reload-gems-in-rails-327-on-eve
        ActionDispatch::Callbacks.to_prepare do
          klass = gem.classify
          Object.send(:remove_const, klass) if Object.const_defined?(klass)
          $".delete_if {|s| s.include?(gem)}
          require gem
        end
      end
    end

    private

    def expanded_gem_path(gem, preferred_path)
      return File.expand_path(preferred_path) if preferred_path
      local_gem = local_gems.find {|g| g[:name] == gem}
      local_gem ? File.expand_path(local_gem[:path]) : false
    end

    def local_gems
      Bundler.definition.specs.
        select{|s| s.source.is_a?(Bundler::Source::Path) }.
        map{|s| {:name => s.name, :path => s.source.path.to_s} }
    end
  end
end
