# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'remarkovable'
  spec.version       = '0.3'
  spec.authors       = ['Jake Worth']
  spec.email         = ['jake@jakeworth.com']
  spec.summary       = 'Markov chains for all.'
  spec.description   = 'A gem that produces Markov chain output from any text.'
  spec.homepage      = 'https://github.com/jwworth/remarkovable'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)})
  spec.require_paths = ['lib']

  spec.add_development_dependency "minitest"
end
