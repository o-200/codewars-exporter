# frozen_string_literal: true

require './lib/codewars_exporter'
require 'terminal-table'

module Api
  class Table
    attr_reader :table, :profile

    def initialize(nickname)
      @table = Terminal::Table.new
      @profile = Api::Profile.new(nickname)
    end

    def create_table
      config_table

      table << profile.full_data
    end

    private

    def config_table
      table.style = {all_separators: true, alignment: :center}
      table.title = 'Codewars'
      table.headings = ['Username', 'Languages', 'rankname', 'score', 'Position', 'total completed']
    end
  end
end
