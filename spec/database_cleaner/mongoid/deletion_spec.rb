require 'support/mongoid_helper'
require 'database_cleaner/mongoid/deletion'

RSpec.describe DatabaseCleaner::Mongoid::Deletion do
  subject(:strategy) { described_class.new }

  describe '#clean' do
    context "with records" do
      before do
        2.times { User.create! }
        2.times { Agent.create! }
      end

      it "should delete all collections" do
        expect { strategy.clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([0,0])
      end

      it "should only delete the collections specified in the :only option when provided" do
        expect { described_class.new(only: ['agents']).clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([2,0])
      end

      it "should not delete the collections specified in the :except option" do
        expect { described_class.new(except: ['users']).clean }
          .to change { [User.count, Agent.count] }
          .from([2,2])
          .to([2,0])
      end

      it "should raise an error when invalid options are provided" do
        expect { described_class.new(foo: 'bar') }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#db=" do
    def with_other_database name
      Mongoid.override_database name
      ret = yield
      Mongoid.override_database :default
      ret
    end

    it "can accept a name to clean another database" do
      with_other_database :second do
        2.times { User.create! }
        2.times { Agent.create! }
      end

      strategy.db = :second

      expect { strategy.clean }
        .to change {
          with_other_database :second do
            [User.count, Agent.count]
          end
        }
        .from([2,2])
        .to([0,0])
    end
  end
end

