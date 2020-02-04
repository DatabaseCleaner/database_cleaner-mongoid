require 'database_cleaner/mongoid/base'
require 'database_cleaner/generic/truncation'
require 'database_cleaner/mongoid/mongoid4_truncation_mixin'
require 'database_cleaner/mongoid/mongoid5_truncation_mixin'
require 'mongoid/version'

module DatabaseCleaner
  module Mongoid
    class Truncation
      include ::DatabaseCleaner::Mongoid::Base
      include ::DatabaseCleaner::Generic::Truncation

      if ::Mongoid::VERSION < '5'
        include ::DatabaseCleaner::Mongoid::Mongoid4TruncationMixin
      else
        include ::DatabaseCleaner::Mongoid::Mongoid5TruncationMixin
      end
    end
  end
end
