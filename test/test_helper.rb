ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"


Dir[Rails.root.join("test/support/**/*.rb")].sort.each { |f| require f }

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)


  fixtures :all
end


class ActionDispatch::IntegrationTest
  include AuthenticationHelpers
end
