# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe Api::Profile do
  # Mocking the HTTP request and response for testing
  let(:nickname) { 'test_user' }
  let(:json_response) { JSON.parse(File.read('spec/test_files/api/profile/o-200.json')) }

  before do
    allow(Net::HTTP).to receive(:get).and_return(json_response.to_json)
  end

  describe '#initialize' do
    it 'creates an instance of Api::Profile' do
      profile = Api::Profile.new(nickname)
      expect(profile).to be_an_instance_of(Api::Profile)
    end
  end

  describe '#full_data' do
    it 'returns an array containing user data' do
      profile = Api::Profile.new(nickname)
      expect(profile.full_data).to match_array(['o-200', "python\nruby\njavascript", '5 kyu', 277, 270_699, 49])
    end
  end
end
