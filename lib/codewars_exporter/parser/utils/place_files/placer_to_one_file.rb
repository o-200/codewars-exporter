# frozen_string_literal: true

class PlacerToOneFile
  include Utils::Constants

  def initialize(data)
    @data = data
  end

  def save
    @data.each do |n|
      File.write(SOLUTION_FILE, "#{n[:solution_name]} #{n[:kyu]}\n", mode: 'a')
      File.write(SOLUTION_FILE, "#{n[:solution]}\n\n", mode: 'a')
    end
  end
end
