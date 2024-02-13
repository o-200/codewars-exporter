module Utils
  class HowSaveChooser
    attr_reader :choice

    def initialize(choice: nil)
      if choice.nil?
        puts "Choose how's save files"

        puts '1) Save every solution to every file'
        puts '2) Save all solutions to one file'

        choice = $stdin.gets.chomp.to_i
      else
        puts(choice == 1 ? 'solutions to every file' : 'solutions to one file')
      end

      @choice = choice
    end
  end
end
