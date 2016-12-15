# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods_kocomojo_sdk'

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-kocomojo-sdk"
  spec.version       = CocoaPodsKocomojoSdk::VERSION
  spec.authors       = ["Elijah Windsor"]
  spec.email         = ["ewindsor@gmail.com"]
  spec.summary       = "KocomojoSDK utility"
  spec.description   = <<-EOF 
    CocoaPods plugin that adds a Build Phase to XCode Project 
    to remove unnecessary architectures from current destination 
    (iOS Simulator, iOS Device) from KocomojoSDK.  

    iOS Apps can leverage KocomojoSDK to add user-defined experiences in response 
    to geolocation / iBeacons.  
  EOF 
  spec.homepage      = "https://github.com/KocomojoLLC/cocoapods-kocomojo-sdk"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 10.0'

  spec.required_ruby_version = '>= 2.0.0'
end