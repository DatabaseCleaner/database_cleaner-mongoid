require 'database_cleaner/strategy'
require 'database_cleaner/mongoid/mongoid4_mixin'
require 'database_cleaner/mongoid/mongoid5_mixin'
require 'mongoid/version'

module DatabaseCleaner
  module Mongoid
    class Deletion < Strategy
      def initialize only: [], except: []
        @only = only
        @except = except
      end

      if ::Mongoid::VERSION < '5'
        include ::DatabaseCleaner::Mongoid::Mongoid4Mixin
      else
        include ::DatabaseCleaner::Mongoid::Mongoid5Mixin
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
