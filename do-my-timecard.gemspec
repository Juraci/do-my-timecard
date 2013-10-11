
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "do-my-timecard"
  spec.version       = "0.0.1"
  spec.authors       = ["Juraci de Lima Vieira Neto"]
  spec.email         = ["juraci.vieira@gmail.com"]
  spec.description   = "do your timecard for you"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = ["lib/do-my-timecard.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara"
  spec.add_dependency "capybara-page-object"
  spec.add_dependency "selenium-webdriver"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
