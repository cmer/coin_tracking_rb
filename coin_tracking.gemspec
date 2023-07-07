
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "coin_tracking/version"

Gem::Specification.new do |spec|
  spec.name          = "coin_tracking"
  spec.version       = CoinTracking::VERSION
  spec.authors       = ["Carl Mercier"]
  spec.email         = ["foss@carlmercier.com"]

  spec.summary       = %q{A Ruby client for CoinTracking.info}
  spec.description   = %q{A Ruby client for CoinTracking.info}
  spec.homepage      = "https://github.com/cmer/coin_tracking_rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "httparty"
end
