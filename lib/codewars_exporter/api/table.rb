# frozen_string_literal: true

require_relative 'profile'
require 'terminal-table'

module Api
  class Table
    attr_reader :profile

    def initialize(nickname)
      @table = Terminal::Table.new
      @profile = Api::Profile.new(nickname)
    end

    def create_table
      config_table

      @table << profile.full_data
    end

    def table
      puts @table
      @table
    end

    private

    def config_table
      @table.style = {all_separators: true, alignment: :center}
      @table.title = 'Codewars'
      @table.headings = ['Username', 'Languages', 'rankname', 'score', 'Position', 'total completed']
    end
  end
end
