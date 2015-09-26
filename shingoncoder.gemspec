# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shingoncoder/version'

Gem::Specification.new do |spec|
  spec.name          = "shingoncoder"
  spec.version       = Shingoncoder::VERSION
  spec.authors       = ["Justin Coyne"]
  spec.email         = ["jcoyne@justincoyne.com"]

  spec.summary       = %q{Create and manage asynchronous transcoding jobs}
  spec.description   = %q{Backed by ActiveJob and FFMpeg}
  spec.homepage      = "https://github.com/jcoyne/shingoncoder"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord'
  spec.add_dependency 'railties'
  spec.add_dependency 'activejob'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
