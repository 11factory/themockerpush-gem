# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'themockerpush/version'

Gem::Specification.new do |gem|
  gem.name          = "themockerpush"
  gem.version       = Themockerpush::VERSION
  gem.authors       = ["Laurent Cobos"]
  gem.email         = ["laurent@11factory.fr"]
  gem.description   = %q{iPhone push notifications as a service - client}
  gem.summary       = %q{iPhone push notifications as a service - client}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
