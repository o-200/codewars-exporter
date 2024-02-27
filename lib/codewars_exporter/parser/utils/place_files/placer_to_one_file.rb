# frozen_string_literal: true

class PlacerToOneFile
  include Utils::Constants

  def initialize(data)
    @data = data
  end

  def save
    @data.each do |n|
      name_kyu = "#{n[:solution_name]} #{n[:kyu]}"

      File.write(SOLUTION_FILE, "#{name_kyu}\n", mode: 'a')
      File.write(SOLUTION_FILE, "#{n[:solution]}\n\n", mode: 'a')

      puts "#{name_kyu} was saved!"
    end
  end
end
