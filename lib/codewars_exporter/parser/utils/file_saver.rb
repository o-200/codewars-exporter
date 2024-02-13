require 'watir'
require 'nokogiri'

module Utils
  class FileSaver
    include Utils::Constants

    def initialize(login, email, password, language, choice)
      @login = login
      @email = email
      @password = password
      @language = language
      @choice = choice
      @browser = Watir::Browser.new :firefox, headless: true

      start_save_solutions
    end

    def start_save_solutions
      login
      puts 'Start parsing solutions!'

      if @choice == 1
        parse.separate_data.place_by_files
        puts "#{solution_path} was created! closing program..."
      else
        parse.separate_data.place_to_one_file
        puts "'#{SOLUTION_FILE}' was created! closing program..."
      end
    end

    # login to codewars
    # takes username and password and trying to gain access to solutions
    def login
      puts 'login to codewars and them start parse, get some coffee if you have a lot of solutions'
      sleep(3)

      @browser.goto(LOGIN_URL)
      @browser.text_field(id: 'user_email').set(@email)
      @browser.text_field(id: 'user_password').set(@password)
      @browser.button(type: 'submit').click

      puts 'logged'
      @browser
    end

    def parse
      @browser.goto(solution_url)
      scrolled_browser = scroll_to_bottom_page(@browser)

      doc = Nokogiri::HTML.parse(scrolled_browser.html)
      @data = doc.css('.list-item-solutions')

      puts 'parsing complete!'
      @browser.close

      self
    end

    # return array with hashes
    # hash-element is a solution which have name, kyu and solution
    def separate_data
      @data = @data.select {|item| item.at('code')['data-language'] == @language }
                  .map { |item|
        {
          solution_name: item.at_css('a').text,
          kyu:           item.at_css('.inner-small-hex').text,
          solution:      item.at_css('pre').text
        }
      }

      self
    end

    # create many files-solutions
    # to separate folder
    def place_by_files
      FileUtils.mkdir_p(solution_path)

      @data.each do |n|
        name_kyu = "#{n[:solution_name]} #{n[:kyu]}"

        File.open(File.join(solution_path, name_kyu), 'w') do |file|
          file.write(n[:solution])
        end

        puts name_kyu
      end
    end

    # creates and writes all data to one file
    def place_to_one_file
      @data.each do |n|
        File.write(SOLUTION_FILE, "#{n[:solution_name]} #{n[:kyu]}\n", mode: 'a')
        File.write(SOLUTION_FILE, "#{n[:solution]}\n\n", mode: 'a')
      end
    end

    def solution_path
      "solutions/#{@language}"
    end

    def scroll_to_bottom_page(browser)
      loop do
        link_number = browser.links.size
        browser.scroll.to :bottom
        sleep(1)

        return browser if browser.links.size == link_number
      end
    end

    def solution_url
      "https://www.codewars.com/users/#{@login}/completed_solutions"
    end
  end
end
