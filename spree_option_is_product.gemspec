# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_option_is_product/version'

Gem::Specification.new do |gem|
  gem.name          = "spree_option_is_product"
  gem.version       = SpreeOptionIsProduct::VERSION
  gem.authors       = ["German Garcia","Ramon Roche"]
  gem.email         = ["geermc4@gmail.com","mrpollo@gmail.com"]
  gem.description   = "Make options in variants a product"
  gem.summary       = "Optionally relate a option to a product so that price and stock for them are taken in to account"
  gem.homepage     = "https://github.com/geermc4/spree_option_is_product"

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]

  gem.add_dependency("spree_core", ">=1.3")
end
