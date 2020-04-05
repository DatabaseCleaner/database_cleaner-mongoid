require "database_cleaner/mongoid/version"
require "database_cleaner/core"
require "database_cleaner/mongoid/truncation"

DatabaseCleaner[:mongoid].strategy = :truncation
