# coding: utf-8
# before all

require 'rspec/expectations'
require 'bundler/setup'
require 'page-object'
require 'page-object/page_factory'
require 'watir'
require 'yaml'
require 'faker'
require 'base64'
require "rest-client"
require 'json'
require 'webdrivers'

World(PageObject::PageFactory)
app = YAML.load_file('config/application.yml')
app['BROWSERSTACK_USER'] = ENV['BROWSERSTACK_USER']
app['BROWSERSTACK_KEY'] = ENV['BROWSERSTACK_KEY']
Webdrivers.install_dir = '/usr/local/bin'

def maximize_browser_window browser
    width = browser.execute_script("return screen.width;")
    height = browser.execute_script("return screen.height;")
    browser.driver.manage.window.resize_to(width,height)
    browser
end

Before do |scenario|
    @app = app
    if @app["BROWSER"] == "firefox"
      @browser = maximize_browser_window(Watir::Browser.new(:firefox, profile: "default", headless: @app["HEADLESS"]))
    elsif @app["BROWSER"] == "chrome"
      @browser = maximize_browser_window(Watir::Browser.new(:chrome, headless: @app["HEADLESS"]))
    else
      # Input capabilities
      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps['browser'] = @app["BROWSERSTACK_BROWSER"]
      caps['browser_version'] = @app["BROWSERSTACK_BROWSER_VERSION"]
      caps['os'] = @app["BROWSERSTACK_OS"]
      caps['os_version'] = @app["BROWSERSTACK_OS_VERSION"]
      caps['resolution'] = @app["BROWSERSTACK_RESOLUTION"]
      caps['name'] = scenario.name
      caps['project'] = "Awesome Browser Automation"
      caps['build'] = "Master"
      url = "http://#{@app['BROWSERSTACK_USER']}:#{@app['BROWSERSTACK_KEY']}@hub-cloud.browserstack.com/wd/hub"
      puts url
      @browser = Watir::Browser.new(:remote,
          :url => url,
          :desired_capabilities => caps)
    end
end
  
After do |scenario|
  if scenario.failed?
    result = "failed"
    embed("data:image/png;base64,#{@browser.screenshot.base64}",'image/png')
  else
    result = "passed"
  end
  if @app["BROWSER"] == "browserstack"
    RestClient.put "https://#{ENV['BROWSERSTACK_USER']}:#{ENV['BROWSERSTACK_KEY']}@api.browserstack.com/automate/sessions/#{@browser.driver.session_id}.json",
      {"status"=>"#{result}", "reason"=>""}, {:content_type => :json}
  end
  @browser.close
end