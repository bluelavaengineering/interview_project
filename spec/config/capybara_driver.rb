## Selenium/chromedriver setup
require "selenium/webdriver"
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.register_driver :insecure_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(disable-gpu disable-web-security disable-xss-auditor) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end
Capybara.javascript_driver = :insecure_chrome
