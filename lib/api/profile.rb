# frozen_string_literal: true

require 'net/http'
require 'json'

module Api
  class Profile
    def initialize(nickname)
      @request = "https://www.codewars.com/api/v1/users/#{nickname}"
      @json = json_request_parse
    end

    def full_data
      [username, languages.join("\n"), rank, honor, leaderboard, total_completed]
    end

    def username
      @json['username']
    end

    def honor
      @json['honor']
    end

    def rank
      @json['ranks']['overall']['name']
    end

    def languages
      @json['ranks']['languages'].keys
    end

    def leaderboard
      @json['leaderboardPosition']
    end

    def total_completed
      @json['codeChallenges']['totalCompleted']
    end

    private

    def json_request_parse
      uri = URI(@request)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end
  end
end
