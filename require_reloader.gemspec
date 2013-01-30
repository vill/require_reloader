# -*- encoding: utf-8 -*-
require File.expand_path('../lib/require_reloader/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Colin Young", "Huiming Teo"]
  gem.email         = ["me@colinyoung.com", "teohuiming@gmail.com"]
  gem.description   = %q{Auto-reload require files or local gems without restarting server during Rails development.}
  gem.summary       = %q{Auto-reload require files or local gems without restarting Rails server.}
  gem.homepage      = "https://github.com/teohm/require_reloader"

  gem.files         = `git ls-files`.split($\).reject{|f| f =~ /^test/}
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "require_reloader"
  gem.require_paths = ["lib"]
  gem.version       = RequireReloader::VERSION

  gem.add_development_dependency "minitest"
end
