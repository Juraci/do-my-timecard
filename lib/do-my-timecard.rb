require 'capybara'
require 'capybara-page-object'
require 'do-my-timecard/base'

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_driver = :selenium
Capybara.default_wait_time = 30
raise "You need an URL" unless ENV['TIMECARD_URL']
Capybara.app_host = ENV['TIMECARD_URL']


Capybara.configure do |config|
  config.match = :smart
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
end
