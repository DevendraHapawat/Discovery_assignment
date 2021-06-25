require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'json'
require 'report_builder'
require 'webdrivers'
require 'capybara-screenshot/cucumber'
require 'pry'

Dir['./features/config/*.rb'].sort.each { |file| require file }
Dir['./features/lib/helpers/*.rb'].sort.each { |file| require file }
Dir['./features/lib/pages/*.rb'].sort.each { |file| require file }
include Capybara::DSL

PropertConfig.set_env_variables

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.javascript_driver = :chrome
  config.default_max_wait_time = 5
  config.match = :first
  config.default_selector = :css
  config.app_host = "http://www.imdb.com"
end

DriverConfig.set_browser_capabilities
CommonHelper.create_report_directories

Before do |scenario|
  Capybara.reset_sessions!
  log('Scenario running: ' + scenario.name)
end

After do |scenario|
  if scenario.failed?
    screenshot = "./screenshot/#{SecureRandom.urlsafe_base64}.png"
    page.save_screenshot(screenshot)
    attach(screenshot, 'image/png', 'SCREENSHOT')
  end
end

at_exit do
  time = Time.now.getutc
  ReportBuilder.configure do |config|
    config.color = 'indigo'
    config.json_path = './results'
    config.report_path = 'cucumber_web_report'
    config.html_report_path = "./reports/#{Time.now.to_s.delete(' ')}"
    config.report_tabs = %w[Overview Features Scenarios Errors]
    config.report_types = [:html]
    config.compress_images = false
    config.report_title = 'IMDB Test Results'
    config.additional_info = { 'Project name' => 'IMDB', 'Platform' => Capybara.app_host,
                               'Report generated' => time }
  end
  ReportBuilder.build_report
end
