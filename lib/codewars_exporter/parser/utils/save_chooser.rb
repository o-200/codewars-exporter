module Utils
  module SaveChooser
    def choose_save_method
      puts "Choose how's save files"

      puts '1) Save every solution to every file'
      puts '2) Save all solutions to one file'

      choice = $stdin.gets.chomp.to_i

      puts(choice == 1 ? 'solutions to every file' : 'solutions to one file')

      choice
    end
  end
end
