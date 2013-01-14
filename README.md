# RequireReloader

[![Gem Version](https://badge.fury.io/rb/require_reloader.png)](http://badge.fury.io/rb/require_reloader)

Auto-reload `require` files or local gems without restarting server
during Rails development.

Currently, it supports Rails 3+ and above, including 3.1 and 3.2.

It uses `ActionDispatch::Callbacks.to_prepare` to reload the
`require` files before each request. In Rails 3.2, it uses 
`watchable_dirs` to reload only when you modify a file. More details in [this blog post](http://teohm.github.com/blog/2013/01/10/reload-required-files-in-rails/).

## Usage

Given a `Gemfile`

    # Gemfile
    gem 'my_gem',  :path => '~/work/my_gem'
    gem 'my_gem2', :path => '~/fun/my_gem2'

To reload all **local gems** (the ones with `:path` attribute, 
or using [local git repo](http://gembundler.com/v1.2/git.html#local)):

    # config/environments/development.rb
    YourApp::Application.configure do
      ...
      RequireReloader.watch_local_gems!
    end

To reload a specific local gem:
    
    RequireReloader.watch :my_gem

You can also **reload a `.rb` file in `lib`** or any directory:

    RequireReloader.watch :half_baked_gem  # in lib dir
    RequireReloader.watch :foo, :path => 'app/models'

The `:path` option is *optional*. In **Rails 3.2**, `:path` value is added into `watchable_dirs`. Rails 3.1 and 3.0 ignore this value.

RequireReloader adds `lib` and `vendor/gems` into `watchable_dirs`. So, specify `:path` only if the file is located in other directory.


## Installation

Add this line to your application's Gemfile:

    gem 'require_reloader'

And then execute:

    $ bundle


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This gem is forked from Colin Young's [gem_reloader](https://github.com/colinyoung/gem_reloader), based on [a solution by Timothy Cardenas](http://timcardenas.com/automatically-reload-gems-in-rails-327-on-eve), inspired by [a post from Leitch](http://ileitch.github.com/2012/03/24/rails-32-code-reloading-from-lib.html).


## Changelog

- v0.1.2: Minor rephrase on gem's description and summary.
- v0.1.1: Use Bundler to fetch local gems info, instead of parsing Gemfile by hand.
- v0.1.0: Forked colinyoung/gem_reloader, renamed & major rewrite to support Rails 3.2 and new features.
- v0.0.2: Added "vendor/gems" to the config.autoload_paths so the user doesn't have to.
