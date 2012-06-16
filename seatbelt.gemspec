# -*- encoding: utf-8 -*-
require File.expand_path('../lib/seatbelt/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thorsten Böttger"]
  gem.email         = ["boettger@mt7.de"]
  gem.description   = %q{Provide custom assertions for Ruby and Ruby on Rails}
  gem.summary       = %q{Provide custom assertions for Ruby and Ruby on Rails}
  gem.homepage      = "http://github.com/also/seatbelt"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "seatbelt"
  gem.require_paths = ["lib"]
  gem.version       = Seatbelt::VERSION

  gem.add_dependency 'multi_json'
  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'actionmailer'
end