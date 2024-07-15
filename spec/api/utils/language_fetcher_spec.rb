# frozen_string_literal: true

require './spec/spec_helper'

module Api
  module Utils
    RSpec.describe ApiHelper do
      let(:helper) { ApiHelper.new }

      describe '#create_method' do
        it 'creates a new method with the given name and block' do
          helper.create_method(:greet) { 'Hello, world!' }
          expect(helper.greet).to eq('Hello, world!')
        end
      end
    end

    RSpec.describe ApiFetcher do
      let(:hash) { JSON.parse(File.read('spec/test_files/api/profile/o-200.json')) }

      let(:api_fetcher) { ApiFetcher.new(hash) }

      describe '#initialize' do
        it 'raises an error if the argument is not a hash' do
          expect { ApiFetcher.new([]) }.to raise_error(ArgumentError, 'Expected a Hash')
        end

        it 'creates methods for each key in the hash' do
          expect(api_fetcher.id).to eq('6264f705d13ea609ad0664e9')
          expect(api_fetcher.username).to eq('o-200')
          expect(api_fetcher.name).to be_nil
          expect(api_fetcher.honor).to eq(277)
          expect(api_fetcher.clan).to be_nil
          expect(api_fetcher.leaderboardPosition).to eq(270_699)
          expect(api_fetcher.skills).to be_nil
          expect(api_fetcher.ranks).to be_a(ApiFetcher)
          expect(api_fetcher.ranks.overall.rank).to eq(-5)
          expect(api_fetcher.ranks.languages.python.rank).to eq(-7)
          expect(api_fetcher.codeChallenges.totalAuthored).to eq(0)
          expect(api_fetcher.codeChallenges.totalCompleted).to eq(49)
        end
      end

      describe '#show' do
        it 'returns the original hash' do
          expect(api_fetcher.show).to eq(hash)
        end
      end
    end
  end
end
