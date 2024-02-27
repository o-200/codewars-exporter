# frozen_string_literal: true

require 'watir'
require 'nokogiri'
require 'pry-byebug'

module Utils
  class NicknameParser
    LOGIN_URL = 'https://www.codewars.com/users/sign_in'
    EDIT_MENU = 'https://www.codewars.com/users/edit'

    attr_reader :email, :password, :username

    def initialize(email, password)
      @browser = Watir::Browser.new :firefox, headless: true
      @email = email
      @password = password

      run
    end

    def run
      login
      parse

      @browser.close
    end

    private

    def login
      puts 'login to codewars and them parse your nickname...'
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

      puts "We're get your nickname, #{@username}"
    end
  end
end
