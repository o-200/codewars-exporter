# frozen_string_literal: true

module Utils
  class HowSaveChooser
    attr_reader :choice

    def initialize(choice=nil)
      if choice.nil?
        puts "Choose how's save files"

        puts '1) Save every solution to every file'
        puts '2) Save all solutions to one file'

        choice = $stdin.gets.chomp.to_i
      end

      if choice.to_i == 1
        @choice = PlacerByFiles
        puts 'solutions to every file'
      else
        @choice = PlacerToOneFile
        puts 'solutions to one file'
      end
    end
  end
end
