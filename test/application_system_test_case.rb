require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: {
    browser: :remote,

    url: ENV.fetch("SELENIUM_URL")
  }

  include AuthenticationHelpers

  setup do
 
    Capybara.server_host = "0.0.0.0"


    Capybara.app_host = "http://web"
  end
end