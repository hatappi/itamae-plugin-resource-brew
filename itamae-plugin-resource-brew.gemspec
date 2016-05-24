# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/resource/brew/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-brew"
  spec.version       = Itamae::Plugin::Resource::Brew::VERSION
  spec.authors       = ["iyuuya"]
  spec.email         = ["i.yuuya@gmail.com"]

  spec.summary       = %q{Itamae resource plugin to manage packages with homebrew/linuxbrew.}
  spec.description   = %q{Itamae resource plugin to manage packages with homebrew/linuxbrew.}
  spec.homepage      = "https://github.com/iyuuya/itamae-plugin-resource-brew"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", "~> 1.9"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
