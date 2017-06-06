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
  session = Selenium::WebDriver.for :chrome, desired_capabilities: caps
  session.manage.timeouts.implicit_wait = 30
  yield session
ensure
  session.quit
end

with_chrome do |session|
  url = 'https://www.google.co.jp'
  session.get url
  name = session.execute_script(<<~EOS)
    return document.getElementsByTagName('title')[0].text
  EOS
  puts "'#{url}' title is '#{name}'"
end
