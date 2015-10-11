# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'remarkovable'
  spec.version       = '0.1'
  spec.authors       = ['Jake Worth']
  spec.email         = ['jake@jakeworth.com']
  spec.summary       = 'Markov chains for all.'
  spec.description   = 'A gem that produces Markov chain output from any text.'
  spec.homepage      = 'http://github.com/jwworth/remarkovable'
  spec.license       = 'MIT'

  spec.files         = ['lib/remarkovable.rb']
  spec.test_files    = ['test/test_remarkovable.rb']
  spec.require_paths = ['lib']
end
