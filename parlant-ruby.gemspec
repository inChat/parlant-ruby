# frozen_string_literal: true

require_relative "lib/parlant/version"

Gem::Specification.new do |spec|
  spec.name          = "parlant-ruby"
  spec.version       = Parlant::VERSION
  spec.authors       = ["InChat LTD", "Rory Gianni"]
  spec.email         = ["team@inchat.design", "rory@inchat.design"]

  spec.summary       = "Ruby client for the Parlant API"
  spec.description   = "A Ruby library for interacting with the Parlant API, providing a simple and idiomatic way to manage agents, customers, sessions, and guidelines."
  spec.homepage      = "https://github.com/inchat/parlant-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.4.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # Use git ls-files if git is available, otherwise fallback to Dir glob
  files = if Dir.exist?('.git')
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{\A(?:(?:bin/(?!console|setup)|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  else
    Dir.glob("{bin,lib}/**/*") + %w[LICENSE README.md CHANGELOG.md]
  end

  spec.files = files
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "http", "~> 5.1"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.56"
  spec.add_development_dependency "simplecov", "~> 0.22"
  spec.add_development_dependency "vcr", "~> 6.2"
  spec.add_development_dependency "webmock", "~> 3.19"
  spec.add_development_dependency "yard", "~> 0.9.34"
end
