class PlacerByFiles
  def initialize(data)
    @data = data
  end

  def save
    FileUtils.mkdir_p(solution_path)

    @data.each do |n|
      name_kyu = "#{n[:solution_name]} #{n[:kyu]}"

      File.open(File.join(solution_path, name_kyu), 'w') do |file|
        file.write(n[:solution])
      end

      puts name_kyu
    end
  end

  private

  def solution_path
    "solutions/#{@language}"
  end
end
