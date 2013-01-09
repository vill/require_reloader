# RequireReloader

Auto-reload local gems or `.rb` files that you `require`'d
**without restarting server** in Rails app development.

Currently, it supports Rails 3+ and above, including 3.1 and 3.2.

It uses `ActionDispatch::Callbacks.to_prepare` to reload the
`require`'d files before each request. In Rails 3.2, it uses 
`watchable_dirs` to reload only when you modify a file.

## Usage

To reload **all** local gems in `Gemfile` (the ones with `:path`
attributes):

    # Gemfile
    ..
    gem 'my_gem',  :path => '~/work/my_gem'
    gem 'my_gem2', :path => '~/fun/my_gem2'


    # config/environments/development.rb
    YourApp::Application.configure do
      ...
      RequireReloader.watch_local_gems!
    end

To reload a local gem specified in `Gemfile`:
    
    # config/environments/development.rb
    YourApp::Application.configure do
      ...
      RequireReloader.watch :my_gem
    end

You can also reload a `.rb` file in `lib` or any directory:

    # config/environments/development.rb
    YourApp::Application.configure do
      ...
      RequireReloader.watch :half_baked_gem  # in lib/
      RequireReloader.watch :foo, :path => 'app/models'
    end

`:path` option is **optional**. In **Rails 3.2**, `:path` value will be 
added into `watchable_dirs`. RequireReloader already adds 
`lib` and `vendor/gems` into `watchable_dirs`. So, you only need to
specify `:path` if the file is located in other directory.


## Installation

Add this line to your application's Gemfile:

    gem 'require_reloader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install require_reloader

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This gem is forked from Colin Young's [gem_reloader](https://github.com/colinyoung/gem_reloader), based on [a solution by Timothy Cardenas](http://timcardenas.com/automatically-reload-gems-in-rails-327-on-eve), inspired by [a post from Leitch](http://ileitch.github.com/2012/03/24/rails-32-code-reloading-from-lib.html).


## Changelog

- v0.1.0: Forked colinyoung/gem_reloader, renamed & major rewrite to support Rails 3.2 and new features.
- v0.0.2: Added "vendor/gems" to the config.autoload_paths so the user doesn't have to.
