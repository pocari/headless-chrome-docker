require 'selenium-webdriver'
require 'nokogiri'

def with_chrome
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => {
      binary: '/usr/bin/google-chrome',
      args: [
        "--headless",
        "--no-sandbox",
        "--disable-gpu",
      ]
    }
  )
  driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
  driver.manage.timeouts.implicit_wait = 30
  yield driver
ensure
  driver.quit
end

with_chrome do |driver|
  url = 'https://www.google.co.jp'
  driver.get url
  name = driver.execute_script(<<~EOS)
    return document.getElementsByTagName('title')[0].text
  EOS
  puts "'#{url}' title is '#{name}'"
end
