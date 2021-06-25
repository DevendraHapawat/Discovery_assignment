# This class configure the app driver.
class DriverConfig
  class << self
    # @return Capyabra selenium browser session
    def set_browser_capabilities
      # TODO: parameterize for appium.
      Capybara.register_driver :selenium do |app|
        case ENV['BROWSER_NAME']
        when 'firefox'
          Capybara::Selenium::Driver.new(app, browser: :firefox)
        when 'safari'
          Capybara::Selenium::Driver.new(app, browser: :safari)
        when 'headless_firefox'
          browser_options = Selenium::WebDriver::Firefox::Options.new
          browser_options.args << '--headless'
          Capybara::Selenium::Driver.new(
            app,
            browser: :firefox,
            options: browser_options
          )
        else
          preferences = {
            download: {
              directory_upgrade: true,
              prompt_for_download: false,
              default_directory: Dir.pwd.to_s
            },
            plugins: {
              always_open_pdf_externally: true
            }
          }
          caps = Selenium::WebDriver::Remote::Capabilities.chrome(
            chromeOptions: { prefs: preferences },
            loggingPrefs: {
              browser: 'ALL'
            }
          )
          Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
        end
      end
    end
  end
end
