module DatabaseCleaner
  module Mongoid
    module Mongoid5TruncationMixin
      def clean
        if @only.any?
          collections.each { |c| database[c].find.delete_many if @only.include?(c) }
        else
          collections.each { |c| database[c].find.delete_many unless @except.include?(c) }
        end
      end

      private

      def database
        if @db.nil? || @db == :default
          ::Mongoid::Clients.default
        else
          ::Mongoid::Clients.with_name(@db)
        end
      end

      def collections
        if db != :default
          database.use(db)
        end

        database.collections.collect { |c| c.namespace.split('.',2)[1] }
      end
    end
  end
end
