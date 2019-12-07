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
Webdrivers.install_dir = '/usr/local/bin'

def maximize_browser_window browser
    width = browser.execute_script("return screen.width;")
    height = browser.execute_script("return screen.height;")
    browser.driver.manage.window.resize_to(width,height)
    browser
end

Before do |scenario|
    @app = app
    if @app["LARQ_BROWSER"] == "firefox"
      @browser = maximize_browser_window(Watir::Browser.new(:firefox, profile: "default", headless: @app["LARQ_HEADLESS"]))
    elsif @app["LARQ_BROWSER"] == "chrome"
      @browser = maximize_browser_window(Watir::Browser.new(:chrome, headless: @app["LARQ_HEADLESS"]))
    end
end
  
After do |scenario|
    if scenario.failed?
      result = "failed"
      embed("data:image/png;base64,#{@browser.screenshot.base64}",'image/png')
    else
      result = "passed"
    end
    @browser.close
end