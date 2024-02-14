require './spec/spec_helper.rb'

RSpec.describe Api::Profile do
  before do
    @test_file_path = './spec/test_files/api/profile/o-200.json'
    @nick = 'o-200'
  end

  describe 'parse data' do
    it 'will correct parse and return correct full_data' do
      expect(Api::Profile.new('o-200', @test_file_path).full_data).to eq(["o-200", "python\nruby\njavascript", "5 kyu", 277, 270699, 49])
    end
  end

  describe '#generate_link' do
    it 'sending link and should return link' do
      test_class = Api::Profile.new(@nick)
      expect(test_class.send(:generate_link, @nick, @test_file_path)).to eq(@test_file_path)
    end

    it 'dont sending link and should return constructed link' do
      test_class = Api::Profile.new(@nick)
      expect(test_class.send(:generate_link, @nick)).to eq("https://www.codewars.com/api/v1/users/#{@nick}")
    end
  end

  describe '#json_request_parse' do
    it 'should correct parse json' do
      test_class = Api::Profile.new(@nick, @test_file_path)
      expect(test_class.send(:json_request_parse, @test_file_path)).to eq(JSON.parse(File.read(@test_file_path)))
    end
  end
end
