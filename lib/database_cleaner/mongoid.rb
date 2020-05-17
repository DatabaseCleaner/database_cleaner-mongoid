require "database_cleaner/mongoid/version"
require "database_cleaner/core"
require "database_cleaner/mongoid/deletion"

DatabaseCleaner[:mongoid].strategy = :deletion
