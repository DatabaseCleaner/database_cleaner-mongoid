module DatabaseCleaner
  module Mongoid
    module Mongoid5Mixin
      def clean
        collections_to_delete.each(&:delete_many)
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
