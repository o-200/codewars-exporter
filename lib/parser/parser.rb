require "watir"
require 'nokogiri'
require 'fileutils'
require 'pry-byebug'
require "./lib/api/profile.rb"

class Parser
  attr_accessor :browser, :email, :password

  def initialize(email = nil, password = nil)
    @email = email
    @password = password
  end

  DATA_FILE = '.data'
  SOLUTION_FILE = 'solutions.txt'
  LOGIN_URL = 'https://www.codewars.com/users/sign_in'
  SOLUTIONS_URL = 'https://www.codewars.com/users/o-200/completed_solutions'

  def run
    choice_language
    request_login_pass
    login

    puts "Starting parsing from browser"

    if choice_how_save == 1
      parse.separate_data.place_to_one_file
    else
      parse.separate_data.place_by_files
    end

    puts "#{SOLUTION_FILE} was created! closing program..."
    @browser.close
  end

  protected

  def choice_how_save
    puts "Choose how's save files"

    puts "1) Save every resolution to every file"
    puts "2) Save all resolutions to one file"

    $stdin.gets.chomp
  end

  def choice_language
    profile = Profile.new(File.open('.codewars-nick').read)

    puts "choose the language which need to parse?"
    puts "I am detected these languages: #{profile.languages.join(', ')}"

    @language = $stdin.gets.chomp.to_s.downcase
  end

  def request_login_pass
    puts "Starting request data..."

    if email.nil? || password.nil?
      puts "Enter your email:"
      email = gets.chomp

      puts "Enter your password:"
      pass = gets.chomp
    else
      puts 'We already have data, skipping stage'
    end
  end

  def login
    @browser = Watir::Browser.new
    @browser.goto(LOGIN_URL)

    @browser.text_field(id: 'user_email').set(email)
    @browser.text_field(id: 'user_password').set(password)
    @browser.button(type: 'submit').click

    return @browser
  end

  def parse
    @browser.goto(SOLUTIONS_URL)
    browser = scroll_to_bottom(@browser)

    doc = Nokogiri::HTML.parse(browser.html)
    @data = doc.css('.list-item-solutions')

    puts 'parsing complete!'
    @browser.close

    self
  end

  def separate_data
    array = []

    @data.each do |item|
      if item.at_css('code').attr('data-language') == @language
        array.push({
          solution_name: item.at_css('a').text,
          kyu: item.at_css('.inner-small-hex').text,
          solution: item.at_css('pre').text
        })
      end
    end

    @data = array
    self
  end

  def place_by_files
    FileUtils.mkdir_p("solutions/#{@language}")

    @data.each do |n|
      name_kyu = "#{n[:solution_name]} #{n[:kyu]}"

      File.open(File.join('solutions', @language, name_kyu), 'w') do |file|
        file.write(n[:solution])
      end

      puts name_kyu
    end
  end

  def place_to_one_file
    @data.each do |n|
      File.write(SOLUTION_FILE, n[:solution_name] + n[:kyu] + "\n", mode: 'a')

      File.write(SOLUTION_FILE, n[:solution] + "\n\n", mode: 'a')
    end
  end

  def scroll_to_bottom(browser)
    loop do
      link_number = browser.links.size
      browser.scroll.to :bottom
      sleep(3)

      break if browser.links.size == link_number
    end

    browser
  end
end
