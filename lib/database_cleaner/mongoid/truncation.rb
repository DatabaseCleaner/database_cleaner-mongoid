require 'database_cleaner/strategy'
require 'database_cleaner/mongoid/mongoid4_truncation_mixin'
require 'database_cleaner/mongoid/mongoid5_truncation_mixin'
require 'mongoid/version'

module DatabaseCleaner
  module Mongoid
    class Truncation < Strategy
      if ::Mongoid::VERSION < '5'
        include ::DatabaseCleaner::Mongoid::Mongoid4TruncationMixin
      else
        include ::DatabaseCleaner::Mongoid::Mongoid5TruncationMixin
      end

      def initialize only: [], except: []
        @only = only
        @except = except
      end

      private

      def collections_to_delete
        only = @only.any? ? @only : collections
        (only - @except).map do |name|
          database[name].find
        end
      end
    end
  end
end
