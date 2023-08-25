require_relative "profile.rb"
require 'terminal-table'

class ApiTable
  def initialize
    @table = Terminal::Table.new
    @profile = Profile.new(File.open('.codewars-nick').read)
  end

  def create_table
    set_style_table
    
    arr = [profile.username, profile.languages.join("\n"), profile.rank, profile.honor, profile.leaderboard, profile.total_completed]
    table << arr

    table
  end

  def table
    @table
  end

  private

  def set_style_table
    table.style = {:all_separators => true, :alignment => :center}
    table.title = 'Codewars'
    table.headings = ['Username', 'Languages', 'rankname', 'score', 'Position', 'total completed']
  end

  def profile
    @profile
  end
end
