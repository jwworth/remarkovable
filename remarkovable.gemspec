# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'remarkovable'
  spec.version       = '0.1'
  spec.authors       = ['Jake Worth']
  spec.email         = ['jake@worth-chicago.co']
  spec.summary       = %q{Markov chains for all}
  spec.description   = %q{A gem that produces Markov chain output from any text.}
  spec.homepage      = 'http://rubygems.org/remarkovable'
  spec.license       = 'MIT'

  spec.files         = ['lib/remarkovable.rb']
  spec.executables   = ['bin/remarkovable']
  spec.test_files    = ['tests/test_remarkovable.rb']
  spec.require_paths = ['lib']
end
