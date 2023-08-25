require_relative "profile.rb"
require 'terminal-table'

class ApiTable
  def initialize
    @table = Terminal::Table.new
    @profile = Profile.new(File.open('.codewars-nick').read)

    create_table(@profile.rank)
  end

  def table
    @table
  end

  def profile
    @profile
  end

  private

  def create_table(hash)
    table.title = 'Codewars'
    table.style = {:all_separators => true}
    table.headings = ['Username', 'Languages', 'rankname', 'score']

    table << [profile.username, profile.languages.join("\n"), profile.rank, profile.honor]
  end
end
