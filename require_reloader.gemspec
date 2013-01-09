# -*- encoding: utf-8 -*-
require File.expand_path('../lib/require_reloader/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Colin Young", "Huiming Teo"]
  gem.email         = ["me@colinyoung.com", "teohuiming@gmail.com"]
  gem.description   = %q{Auto-reload local gems or .rb files you required in Rails development.}
  gem.summary       = %q{Auto-reload local gems or .rb files that you required without restarting server during Rails app development.}
  gem.homepage      = "https://github.com/teohm/require_reloader"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "require_reloader"
  gem.require_paths = ["lib"]
  gem.version       = RequireReloader::VERSION
end
