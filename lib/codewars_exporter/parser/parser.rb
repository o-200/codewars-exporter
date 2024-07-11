# frozen_string_literal: true

require 'fileutils'

require './lib/codewars_exporter/api'
require_relative 'utils'

##
# This class is a parser which getting and represents solutions
class Parser
  include Utils::Constants

  attr_accessor :email, :password, :choice, :language

  def initialize(email=nil, password=nil, choice=nil, language=nil)
    @email = email
    @password = password
    @choice = choice
    @language = language
  end

  # main method which takes parsing and saving process
  def run
    request_login_pass
    find_nick

    choice_language
    choice_how_save

    save_solutions
    finish_process
  end

  private

  # +Utils::AccessRequester+
  # checking for access data and renew instance variables
  # for getting actual data if user forgot put them
  def request_login_pass
    return unless @email.nil? || @password.nil?

    @email, @password = Utils::AccessRequester.new(@email, @password)
  end

  # +Utils::NicknameParser+ - class
  # parser username of codewars account
  def find_nick
    @nickname = Utils::NicknameParser.new(@email, @password).username
  end

  # +Api::Profile+
  # finds languages and give list to choice of them
  def choice_language
    profile = Api::Profile.new(@nickname)

    puts 'choose the language which need to parse?'
    puts "I am detected these languages: [#{profile.languages.join(', ')}]"

    @language = $stdin.gets.chomp.to_s.downcase if @language.nil?
    system('clear')
    puts "okay, your choise is #{@language}"
  end

  # +Utils::HowSaveChooser+
  # checking how we need to save files, asking user about that
  def choice_how_save
    @choice = Utils::HowSaveChooser.new(@choice).choice
  end

  # +Utils::FileSaver+
  # start scenario of saving to files
  def save_solutions
    Utils::FileSaver.new(@nickname, @email, @password, @language, @choice)
  end

  def finish_process
    puts 'Work completed! Closing browser...'
    sleep 5
    system('clear')
  end
end
