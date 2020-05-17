# Database Cleaner Adapter for Mongoid

[![Build Status](https://travis-ci.org/DatabaseCleaner/database_cleaner-mongoid.svg?branch=master)](https://travis-ci.org/DatabaseCleaner/database_cleaner-mongoid)
[![Code Climate](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-mongoid/badges/gpa.svg)](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-mongoid)
[![codecov](https://codecov.io/gh/DatabaseCleaner/database_cleaner-mongoid/branch/master/graph/badge.svg)](https://codecov.io/gh/DatabaseCleaner/database_cleaner-mongoid)

Clean your Mongoid databases with Database Cleaner.

See https://github.com/DatabaseCleaner/database_cleaner for more information.

## Installation

```ruby
# Gemfile
group :test do
  gem 'database_cleaner-mongoid'
end
```

## Supported Strategies

The mongoid adapter only has one strategy: the deletion strategy.

## Strategy configuration options

`:only` and `:except` may take a list of collection names:

```ruby
# Only delete the "users" collection.
DatabaseCleaner[:mongoid].strategy = :deletion, { only: ["users"] }

# Delete all collections except the "users" collection.
DatabaseCleaner[:mongoid].strategy = :deletion, { except: ["users"] }
```

## Adapter configuration options

`#db` defaults to the default Mongoid database, but can be specified manually in a few ways:

```ruby
# Redis URI string:
DatabaseCleaner[:mongoid].db = :logs

# Back to default:
DatabaseCleaner[:mongoid].db = :default

# Multiple Mongoid databases can be specified:
DatabaseCleaner[:mongoid, connection: :default]
DatabaseCleaner[:mongoid, connection: :shard_1]
DatabaseCleaner[:mongoid, connection: :shard_2]
```

## COPYRIGHT

See [LICENSE](LICENSE) for details.
