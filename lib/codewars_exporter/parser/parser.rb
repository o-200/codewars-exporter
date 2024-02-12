# frozen_string_literal: true

require 'watir'
require 'nokogiri'
require 'fileutils'

require './lib/codewars_exporter/api/profile'
require_relative 'utils/utils.rb'

##
# This class is a parser which getting and represents solutions
class Parser
  include Utils::AccessRequester
  include Utils::Constants
  include Utils::FileSaver
  include Utils::HowSaveChooser

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
    save_solutions

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

  # +Utils::NicknameParser+ - class
  # parser username of codewars account
  def find_nick
    parser = Utils::NicknameParser.new(@email, @password)
    parser.run
    @nickname = parser.username
  end

  # +Api::Profile+
  # finds languages and give list to choice of them
  def choice_language
    profile = Api::Profile.new(@nickname)

    puts 'choose the language which need to parse?'
    puts "I am detected these languages: #{profile.languages.join(', ')}"

    @language = $stdin.gets.chomp.to_s.downcase

    puts "okay, your choise is #{@language}"
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

  def save_solutions
    start_save_solutions(@choice, @language)
  end

  def solution_url(nickname)
    "https://www.codewars.com/users/#{nickname}/completed_solutions"
  end
end
