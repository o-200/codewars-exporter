module Utils
  module FileSaver
    SOLUTION_FILE = 'solution.txt'

    def start_save_solutions(choice, language)
      puts 'Start parsing solutions!'

      if choice == 1
        parse.separate_data(language).place_by_files(language)
        puts "#{solution_path(language)} was created! closing program..."
      else
        parse.separate_data(language).place_to_one_file
        puts "'#{SOLUTION_FILE}' was created! closing program..."
      end
    end

    # return array with hashes
    # hash-element is a solution which have name, kyu and solution
    def separate_data(language)
      @data = @data.select {|item| item.at('code')['data-language'] == language }
                  .map {|item|
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
    def place_by_files(language)
      FileUtils.mkdir_p(solution_path(language))

      @data.each do |n|
        name_kyu = "#{n[:solution_name]} #{n[:kyu]}"

        File.open(File.join(solution_path(language), name_kyu), 'w') do |file|
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

    def solution_path(language)
      "solutions/#{language}"
    end
  end
end
