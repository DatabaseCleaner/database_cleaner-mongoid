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
  end
end

