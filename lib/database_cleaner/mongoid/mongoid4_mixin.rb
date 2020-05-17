module DatabaseCleaner
  module Mongoid
    module Mongoid4Mixin
      def clean
        collections_to_delete.each(&:remove_all)
        wait_for_removals_to_finish
      end

      private

      def database
        ::Mongoid.default_session
      end

      def collections
        if db != :default
          database.use(db)
        end

        database.command(listCollections: 1, filter: { 'name' => { '$not' => /.?system\.|\$/ } })['cursor']['firstBatch'].map do |collection|
          collection['name']
        end
      end

      def wait_for_removals_to_finish
        database.command(getlasterror: 1)
      end
    end
  end
end
