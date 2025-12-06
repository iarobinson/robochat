# frozen_string_literal: true

require_relative "lib/robochat/version"

Gem::Specification.new do |spec|
  spec.name = "robochat"
  spec.version = Robochat::VERSION
  spec.authors = ["Ian Robinson"]
  spec.email = ["ian@ianrobinson.net"]

  spec.summary = "A ruby gem for adding LLM support to your Ruby on Rails application."
  spec.description = "Adding this gem to your Ruby on Rails project allows for quick API integration to various LLM APIs."
  spec.homepage = "https://github.com/iarobinson/robochat"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["allowed_push_host"] = spec.homepage

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/iarobinson/robochat/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[app/ lib/ config/ bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.files += %w[LICENSE README.md] if File.exist?("LICENSE") && File.exist?("README.md")

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "openai", "~> 4.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 2.0"

  # Add CLI
  spec.executables = Dir["bin/*"].map{ |f| File.basename(f) }
end
