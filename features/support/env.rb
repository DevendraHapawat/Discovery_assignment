require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'rspec'
require 'pry'
require 'json'
require 'report_builder'
#require 'webdrivers'

Dir['#{Dir.pwd}/features/lib/helpers/*.rb'].sort.each { |file| require file }
Dir['#{Dir.pwd}/features/lib/pages/*.rb'].sort.each { |file| require file }

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :poltergeist
Capybara.configure do |config|
  Capybara.app_host = 'https://go.discovery.com'
  include RSpec::Matchers
  include Capybara::DSL
  config.include Capybara::DSL, type: :feature
  config.run_server = false
  config.default_selector = :css
  config.default_driver = :selenium
end

Before do |scenario|
  Capybara.reset_sessions!
  puts 'Scenario running: ' + scenario.name
end

After do |scenario|
  if scenario.failed?
    screenshot = "./screenshot/#{SecureRandom.urlsafe_base64}.png"
    page.save_screenshot(screenshot)
    embed(screenshot, 'image/png', 'SCREENSHOT')
  end
end

at_exit do
  dirname = File.dirname('./Report/result')
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  ReportBuilder.configure do |config|
    config.json_path = './Report'
    config.html_report_path = './Report/result'
    config.report_types = [:html]
    config.report_title = 'Test Results'
    config.additional_info = { Browser: 'Chrome', Environment: 'Discovery' }
  end
  ReportBuilder.build_report
end
