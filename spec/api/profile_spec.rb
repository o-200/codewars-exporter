# profile_spec.rb
require './spec/spec_helper.rb'

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
      expect(profile.full_data).to match_array(["o-200", "python\nruby\njavascript", "5 kyu", 277, 270699, 49])
    end
  end

  describe '#username' do
    it 'returns the correct username' do
      profile = Api::Profile.new(nickname)
      expect(profile.username).to eq('o-200')
    end
  end

  describe '#honor' do
    it 'returns the correct honor value' do
      profile = Api::Profile.new(nickname)
      expect(profile.honor).to eq(277)
    end
  end

  describe '#rank' do
    it 'returns the correct rank' do
      profile = Api::Profile.new(nickname)
      expect(profile.rank).to eq('5 kyu')
    end
  end

  describe '#languages' do
    it 'returns the list of languages' do
      profile = Api::Profile.new(nickname)
      expect(profile.languages).to eq(['python', 'ruby', 'javascript'])
    end
  end

  describe '#leaderboard' do
    it 'returns the correct leaderboard position' do
      profile = Api::Profile.new(nickname)
      expect(profile.leaderboard).to eq(270699)
    end
  end

  describe '#total_completed' do
    it 'returns the correct total completed challenges' do
      profile = Api::Profile.new(nickname)
      expect(profile.total_completed).to eq(49)
    end
  end
end
