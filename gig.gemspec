require File.expand_path("lib/github_image_grep/version", __dir__)

Gem::Specification.new do |spec|
  spec.name        = "gig"
  spec.version     = GithubImageGrep::VERSION
  spec.licenses    = ["MIT"]
  spec.summary     = "Sample gem that can download profile images from GitHub repositories"
  spec.description = "Command line tool using the public GitHub API to download and save avatar images from repository owners matching the
provided search criteria."
  spec.authors     = ["Filippo Ragazzo"]
  spec.email       = "filipporagazzo89@gmail.com"
  spec.homepage    = "https://github.com/pippokairos/gig"
  spec.platform    = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'
  spec.files       = Dir[
                       "README.md",
                       "LICENSE",
                       "lib/**/*.rb",
                       "gig.gemspec",
                       ".github/*.md",
                       "Gemfile",
                       "Rakefile"
                      ]

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
end
