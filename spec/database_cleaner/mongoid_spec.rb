require 'database_cleaner/mongoid'
require 'database_cleaner/spec'

RSpec.describe DatabaseCleaner::Mongoid do
  it_should_behave_like "a database_cleaner adapter"
end
