require "database_cleaner/generic/base"

module DatabaseCleaner
  module Mongoid
    def self.available_strategies
      %i[truncation]
    end

    def self.default_strategy
      available_strategies.first
    end

    module Base
      include ::DatabaseCleaner::Generic::Base

      def db=(desired_db)
        @db = desired_db
      end

      def db
        @db || :default
      end
    end
  end
end
