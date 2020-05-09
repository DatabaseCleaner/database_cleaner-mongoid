module DatabaseCleaner
  module Mongoid
    module Mongoid4TruncationMixin
      def clean
        if @only.any?
          collections.each { |c| session[c].find.remove_all if @only.include?(c) }
        else
          collections.each { |c| session[c].find.remove_all unless @except.include?(c) }
        end
        wait_for_removals_to_finish
      end

      private

      def session
        ::Mongoid.default_session
      end

      def db_version
        @db_version ||= session.command('buildinfo' => 1)['version']
      end

      def collections
        if db != :default
          session.use(db)
        end

        session.command(listCollections: 1, filter: { 'name' => { '$not' => /.?system\.|\$/ } })['cursor']['firstBatch'].map do |collection|
          collection['name']
        end
      end

      def wait_for_removals_to_finish
        session.command(getlasterror: 1)
      end
    end
  end
end
