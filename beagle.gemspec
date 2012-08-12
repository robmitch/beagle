$: << File.expand_path("../lib", __FILE__)
require "beagle/version"

Gem::Specification.new do |gem|

  gem.name = "beagle"
  gem.summary = "Provides execution times for your specs for analysis"
  gem.homepage = "http://github.com/robmitch/beagle"
  gem.authors = ["Rob Mitchell"]
  gem.email = "robm.mitchell@gmail.com"

  gem.version = Beagle::VERSION.dup
  gem.platform = Gem::Platform::RUBY
  gem.add_runtime_dependency("rspec-core", ">= 2.0.0")

  gem.add_development_dependency("rake", "~> 0.8.7")
  gem.add_development_dependency("rspec", "~> 2.0.0")

  gem.require_path = "lib"
  gem.files = Dir["lib/**/*", "README.markdown"]
  gem.test_files = Dir["spec/**/*", "Rakefile"]

end
