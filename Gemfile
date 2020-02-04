source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in database_cleaner-mongoid.gemspec
gemspec

gem "byebug"

gem "activesupport", "~>5.2" if RUBY_VERSION =~ /^2\.4\./

gem "database_cleaner-core", github: "DatabaseCleaner/database_cleaner", branch: "v2.0.0.beta"
