class RequireReloaderRailtie < Rails::Railtie

  initializer 'require_reloader.autoload', :before => :set_autoload_paths do |app|
    app.config.autoload_paths += Dir["#{app.config.root}/vendor/gems/"]
  end

  initializer 'require_reloader.add_watchable_dirs', :before => :set_autoload_paths do |app|
    if app.config.respond_to?(:watchable_dirs)
      app.config.watchable_dirs['vendor/gems'] = [:rb]
      app.config.watchable_dirs['lib'] = [:rb]
    end
  end

end
