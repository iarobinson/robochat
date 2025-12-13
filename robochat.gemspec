# frozen_string_literal: true

require_relative "lib/robochat/version"

Gem::Specification.new do |spec|
  spec.name = "robochat"
  spec.version = Robochat::VERSION
  spec.authors = ["Useful Programmer"]
  spec.email = ["ian@usefulprogrammer.org"]

  spec.summary = "A ruby gem for adding LLM support to your Ruby on Rails application."
  spec.description = "Adding this gem to your Ruby on Rails project allows for quick API integration to various LLM APIs."
  spec.homepage = "https://github.com/iarobinson/robochat"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = spec.homepage

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/iarobinson/robochat/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.files += %w[LICENSE README.md] if File.exist?("LICENSE") && File.exist?("README.md")

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "httparty", "~> 0.21"

  spec.add_dependency "openai", ">= 0.37.0"
  spec.add_dependency "httparty", "~> 0.21"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 2.0"

  # TODO: Add this for a CLI integration
  spec.executables = Dir["exe/*"].map { |f| File.basename(f) }
end
