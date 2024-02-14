# frozen_string_literal: true

require 'net/http'
require 'json'

module Api
  class Profile
    def initialize(nickname, link = nil)
      request = generate_link(nickname, link)
      @json = json_request_parse(request)
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

    def generate_link(nickname, link = nil)
      link ? link : "https://www.codewars.com/api/v1/users/#{nickname}"
    end

    def json_request_parse(request)
      uri = URI(request)

      response = begin
                   Net::HTTP.get(uri)
                 rescue Errno::ECONNREFUSED => e
                   File.read(request)
                 end

      JSON.parse(response)
    end
  end
end
