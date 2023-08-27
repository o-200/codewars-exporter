require "watir"
require 'nokogiri'
require 'pry-byebug'

class Parser
  attr_accessor :browser

  DATA_FILE = '.data'
  SOLUTION_FILE = 'solutions.txt'
  LOGIN_URL = 'https://www.codewars.com/users/sign_in'
  SOLUTIONS_URL = 'https://www.codewars.com/users/o-200/completed_solutions'

  def initialize
    @browser = Watir::Browser.new
  end

  def run
    request_data
    login
    
    parse.separate_data.place_to_one_file

    puts "#{SOLUTION_FILE} was created! closing program..."
    @browser.close
  end

  # private

  def request_data
    puts "starting request data..."

    unless File.exists?(DATA_FILE)
      puts "Enter your email:"
      email = gets.chomp

      puts "Enter your password:"
      pass = gets.chomp

      file = File.new(DATA_FILE, 'w+')
      File.write(file, [email, pass].join("\n"))
    else
      puts 'We already have data, skipping stage'
    end
  end

  def login
    data = File.read(DATA_FILE).split("\n")

    @browser.goto(LOGIN_URL)

    @browser.text_field(id: 'user_email').set(data[0])
    @browser.text_field(id: 'user_password').set(data[1])
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
      array.push({
        solution_name: item.at_css('a').text,
        kyu: item.at_css('.inner-small-hex').text,
        solution: item.at_css('pre').text
      })
    end

    @data = array
    self
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
