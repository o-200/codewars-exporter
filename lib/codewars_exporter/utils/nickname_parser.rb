# frozen_string_literal: true

require './lib/codewars_exporter/utils/browser'
require 'nokogiri'

module Utils
  class NicknameParser
    LOGIN_URL = 'https://www.codewars.com/users/sign_in'
    EDIT_MENU = 'https://www.codewars.com/users/edit'

    attr_reader :email, :password, :username

    def initialize(email, password)
      @browser = Browser.new
      @email = email
      @password = password
    end

    def run
      login
      parse

      @browser.close
      self
    end

    private

    def login
      puts 'Logging into Codewars and then parsing your nickname...'
      @browser.goto(LOGIN_URL)

      @browser.text_field(id: 'user_email').set(email)
      @browser.text_field(id: 'user_password').set(password)
      @browser.button(type: 'submit').click
    end

    def parse
      @browser.goto(EDIT_MENU)

      doc = Nokogiri::HTML.parse(@browser.html)
      doc = doc.css('.user_username')
      @username = doc.at_css('input#user_username')['value']

      puts "We've got your nickname: #{@username}"
    end
  end
end
