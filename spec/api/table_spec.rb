# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe Api::Table do
  let(:nickname) { 'test_user' }
  let(:profile_double) { instance_double(Api::Profile, full_data: ['test_user', 'Ruby', '3 kyu', 1000, 42, 50]) }

  before do
    allow(Api::Profile).to receive(:new).with(nickname).and_return(profile_double)
  end

  describe '#table' do
    it 'prints the table to the console' do
      table_instance = Api::Table.new(nickname)
      table_instance.create_table

      output = StringIO.new
      $stdout = output

      table_instance.table
      $stdout = STDOUT

      expected_output = File.read('spec/test_files/api/table/table.txt')
      expect(output.string.strip).to eq(expected_output.strip)
    end
  end
end
