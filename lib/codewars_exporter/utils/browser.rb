# frozen_string_literal: true

require 'watir'

class Browser
  attr_accessor :browser

  def initialize
    Selenium::WebDriver::Firefox::Service.driver_path = '/usr/local/bin/geckodriver'
    options = Selenium::WebDriver::Firefox::Options.new
    options.binary = '/usr/bin/firefox-esr'
    @browser = Watir::Browser.new(:firefox, options:, headless: true)
  end

  def method_missing(method_name, *args, &block)
    if @browser.respond_to?(method_name)
      @browser.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name)
    @browser.respond_to?(method_name) || super
  end
end
