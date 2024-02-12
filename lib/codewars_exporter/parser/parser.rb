# frozen_string_literal: true

require 'watir'
require 'nokogiri'
require 'fileutils'
require './lib/codewars_exporter/api/profile'
require_relative 'utils/access_requester.rb'
require_relative 'utils/constants.rb'
require_relative 'utils/save_chooser.rb'
require_relative 'utils/file_saver.rb'
require_relative 'nickname_parser'

##
# This class is a parser which getting and represents solutions
class Parser
  include Utils::AccessRequester
  include Utils::SaveChooser
  include Utils::Constants
  include Utils::FileSaver

  DATA_FILE = '.data'
  LOGIN_URL = 'https://www.codewars.com/users/sign_in'

  attr_accessor :browser, :email, :password, :choice

  def initialize(email=nil, password=nil, choice = nil)
    @email = email
    @password = password
    @choice = choice

    @browser = Watir::Browser.new :firefox, headless: true
  end

  # main method which takes parsing and saving process
  def run
    request_login_pass
    find_nick

    choice_language
    choice_how_save

    login
    start_save_solutions(@choice, @language)

    puts 'Work completed! Closing browser...'
    @browser.close
  end

  protected

  # +Utils::AccessRequester+
  # checking for access data and renew instance variables
  # for getting actual data if user forgot put them
  def request_login_pass
    request_data(@email, @password)
  end

  # +NicknameParser+
  # parser username of codewars account
  def find_nick
    parser = NicknameParser.new(@email, @password)
    parser.run
    @nickname = parser.username
  end

  # +Utils::SaveChooser+
  # checking how we need to save files, asking user about that
  def choice_how_save
    if @choice.nil?
      @choice = choose_save_method
    else
      puts "we already known how save files, skipping..."
    end
  end

  # finds languages and give choise for them
  def choice_language
    profile = Api::Profile.new(@nickname)

    puts 'choose the language which need to parse?'
    puts "I am detected these languages: #{profile.languages.join(', ')}"

    @language = $stdin.gets.chomp.to_s.downcase

    puts "okay, your choise is #{@language}"
  end

  # login to codewars
  # takes username and password and trying to gain access to solutions
  def login
    puts 'login to codewars and them start parse, get some coffee if you have a lot of solutions'
    sleep(3)

    @browser.goto(LOGIN_URL)
    @browser.text_field(id: 'user_email').set(email)
    @browser.text_field(id: 'user_password').set(password)
    @browser.button(type: 'submit').click

    @browser
  end

  # parsing process
  # redirect to solution page and saves all page
  def parse
    @browser.goto(solution_url(@nickname))
    browser = scroll_to_bottom_page(@browser)

    doc = Nokogiri::HTML.parse(browser.html)
    @data = doc.css('.list-item-solutions')

    puts 'parsing complete!'
    @browser.close

    self
  end

  # TODO: move to separate module
  # utils method which scroll browser window down
  def scroll_to_bottom_page(browser)
    loop do
      link_number = browser.links.size
      browser.scroll.to :bottom
      sleep(2)

      return browser if browser.links.size == link_number
    end
  end

  def solution_url(nickname)
    "https://www.codewars.com/users/#{nickname}/completed_solutions"
  end
end
