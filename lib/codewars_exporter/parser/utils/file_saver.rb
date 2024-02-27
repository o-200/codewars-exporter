# frozen_string_literal: true

require 'watir'
require 'nokogiri'

module Utils
  # The Utils module contains various utility classes and modules.
  class FileSaver
    include Utils::Constants

    # +Utils::FileSaver+
    # This class is responsible for logging into Codewars, parsing solutions, and saving them to files.

    # Initializes a new instance of FileSaver.
    #
    # @param login [String] The Codewars username.
    # @param email [String] The email address associated with the Codewars account.
    # @param password [String] The password for the Codewars account.
    # @param language [String] The programming language of solutions to be parsed.
    # @param choice_class [Class] The user's choice for saving solutions (returns class of which save method),
    #   Template Method pattern
    def initialize(login, email, password, language, choice_class)
      @login = login
      @email = email
      @password = password
      @language = language
      @choice_class = choice_class
      @browser = Watir::Browser.new :firefox, headless: true

      start_save_solutions
    end

    # Initiates the process of logging in, parsing solutions, and saving them based on user's choice.
    def start_save_solutions
      login
      puts 'Start parsing solutions!'

      parse.separate_data
      @choice_class.new(@data).save
      puts 'Program was completed...'
    end

    # Logs into Codewars using the provided credentials.
    #
    # @return [Watir::Browser] The browser instance after successful login.
    def login
      puts 'Login to Codewars and then start parsing. Get some coffee if you have a lot of solutions.'
      sleep(3)

      @browser.goto(LOGIN_URL)
      @browser.text_field(id: 'user_email').set(@email)
      @browser.text_field(id: 'user_password').set(@password)
      @browser.button(type: 'submit').click

      puts 'Logged up successfully.'
      @browser
    end

    # Parses the HTML content of the solutions page and stores the data.
    #
    # @return [Utils::FileSaver] The current instance of FileSaver.
    def parse
      @browser.goto(solution_url)
      scrolled_browser = scroll_to_bottom_page(@browser)

      doc = Nokogiri::HTML.parse(scrolled_browser.html)
      @data = doc.css('.list-item-solutions')

      puts 'Parse method was success!'
      @browser.close

      self
    end

    # Separates the parsed data based on the selected programming language.
    #
    # @return [Utils::FileSaver] The current instance of FileSaver.
    def separate_data
      @data = @data.select {|item| item.at('code')['data-language'] == @language }
                   .map {|item|
        {
          solution_name: item.at_css('a').text,
          kyu:           item.at_css('.inner-small-hex').text,
          solution:      item.at_css('pre').text
        }
      }

      self
    end

    # Generates the path for the solution files based on the selected programming language.
    #
    # @return [String] The path for saving solution files.
    def solution_path
      "solutions/#{@language}"
    end

    # Scrolls to the bottom of the page to load additional solutions.
    #
    # @param browser [Watir::Browser] The browser instance.
    # @return [Watir::Browser] The browser instance after scrolling to the bottom.
    def scroll_to_bottom_page(browser)
      loop do
        link_number = browser.links.size
        browser.scroll.to :bottom
        sleep(1)

        return browser if browser.links.size == link_number
      end
    end

    # Generates the URL for accessing the user's completed solutions on Codewars.
    #
    # @return [String] The URL for accessing completed solutions.
    def solution_url
      "https://www.codewars.com/users/#{@login}/completed_solutions"
    end
  end
end
