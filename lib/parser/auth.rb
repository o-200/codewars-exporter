require "watir"
require 'nokogiri'
require 'pry-byebug'

def login
  puts "Enter your email:"
  email = gets.chomp()

  puts "Enter your password:"
  pass = gets.chomp()

  browser = Watir::Browser.start 'https://www.codewars.com/users/sign_in'

  browser.text_field(id: 'user_email').set(email)
  browser.text_field(id: 'user_password').set(pass)
  browser.button(type: 'submit').click

  parse(browser)
end

def parse(browser)
  browser.goto 'https://www.codewars.com/users/o-200/completed_solutions'

  browser = scroll_to_bottom(browser)

  doc = Nokogiri::HTML.parse(browser.html)
  item_list = doc.css('.list-item-solutions')
  item_list.css('pre').each do |n|
    place_to_file(n)
  end

  binding.pry
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

def place_to_file(html)
  File.write('solutions.txt', html.text + "\n\n", mode: 'a')
end


login
