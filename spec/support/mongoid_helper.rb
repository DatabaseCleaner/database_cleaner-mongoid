require "mongoid"

Mongoid.load! "spec/support/connection.yml", :test

class User
  include Mongoid::Document
end

class Agent
  include Mongoid::Document
end

RSpec.configure do |config|
  config.before do
    User.delete_all
    Agent.delete_all
  end
end
