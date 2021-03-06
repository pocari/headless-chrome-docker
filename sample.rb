require 'selenium-webdriver'
# require 'nokogiri'

def with_chrome
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => {
      binary: '/usr/bin/google-chrome',
      args: [
        "--headless",
        "--no-sandbox",
        "--disable-gpu"
      ]
    }
  )
  driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
  driver.manage.timeouts.implicit_wait = 30
  yield driver
rescue => e
  $stderr.puts(e.backtrace)
ensure
  driver.quit
end

with_chrome do |driver|
  url = 'https://sikmi.com'
  driver.get url
  # require 'pry-byebug'; binding.pry
  title = driver.execute_script(<<~EOS)
    function js_function_test(str) {
      return str + " added by function";
    }
    return js_function_test(document.getElementsByTagName('title')[0].text);
  EOS
  puts "'#{url}' title is '#{title}'"
  width  = driver.execute_script("return Math.max(document.body.scrollWidth, document.body.offsetWidth, document.documentElement.clientWidth, document.documentElement.scrollWidth, document.documentElement.offsetWidth);")
  height = driver.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")

  puts "height: #{height}, width: #{width}"
  driver.manage.window.resize_to(width+100, height+100)
  driver.save_screenshot('/var/ruby/screenshot.png')
end
