require_relative "profile.rb"
require 'terminal-table'

class ApiTable
  attr_reader :table, :profile

  def initialize(nickname)
    @table = Terminal::Table.new
    @profile = Profile.new(nickname)
  end

  def create_table
    config_table

    table << profile.full_data
  end

  private

  def config_table
    table.style = {:all_separators => true, :alignment => :center}
    table.title = 'Codewars'
    table.headings = ['Username', 'Languages', 'rankname', 'score', 'Position', 'total completed']
  end
end
