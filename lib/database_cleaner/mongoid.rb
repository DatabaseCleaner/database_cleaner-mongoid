require "database_cleaner/mongoid/version"
require "database_cleaner/core"
require "database_cleaner/mongoid/truncation"

module DatabaseCleaner::Mongoid
  def self.default_strategy
    :truncation
  end
end

