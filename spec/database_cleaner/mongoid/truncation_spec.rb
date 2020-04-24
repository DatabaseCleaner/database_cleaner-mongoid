require 'support/mongoid_helper'
require 'database_cleaner/mongoid/truncation'

RSpec.describe DatabaseCleaner::Mongoid::Truncation do
  subject(:strategy) { described_class.new }

  describe '#clean' do
    context "with records" do
      before do
        2.times { User.create! }
        2.times { Agent.create! }
      end

      it "should truncate all tables" do
        expect { strategy.clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([0,0])
      end

      it "should only truncate the tables specified in the :only option when provided" do
        expect { described_class.new(only: ['agents']).clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([2,0])
      end

      it "should not truncate the tables specified in the :except option" do
        expect { described_class.new(except: ['users']).clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([2,0])
      end

      it "should raise an error when invalid options are provided" do
        expect { described_class.new(foo: 'bar') }.to raise_error(ArgumentError)
      end
    end

    describe "with pre_count optimization option" do
      subject(:strategy) { described_class.new(pre_count: true) }

      xit "only truncates non-empty tables" do
        User.create!
        expect(connection).to receive(:truncate_tables).with(tables)
        strategy.clean
      end
    end

    context 'when :cache_tables is set to true' do
      xit 'caches the list of tables to be truncated' do
        expect(connection).to receive(:database_cleaner_table_cache).and_return([])
        expect(connection).not_to receive(:tables)

        allow(connection).to receive(:truncate_tables)
        described_class.new(cache_tables: true).clean
      end
    end

    context 'when :cache_tables is set to false' do
      xit 'does not cache the list of tables to be truncated' do
        expect(connection).not_to receive(:database_cleaner_table_cache)
        expect(connection).to receive(:database_tables).and_return([])

        allow(connection).to receive(:truncate_tables)
        described_class.new(cache_tables: false).clean
      end
    end
  end
end

