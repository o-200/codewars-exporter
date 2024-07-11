# frozen_string_literal: true

require_relative 'utils'

require 'net/http'
require 'json'

module Api
  class Profile
    # +Api::Utils::ApiFetcher+
    # creates the Tree of parsed hash, check ApiFetcher for more
    def initialize(nickname)
      @request = "https://www.codewars.com/api/v1/users/#{nickname}"
      @json = Api::Utils::ApiFetcher.new(json_request_parse)
    end

    # method_missing is here
    def full_data
      [username, languages, rank, honor, leaderboardPosition, total_completed]
    end

    private

    # creates a lot of methods which not explicit
    def method_missing(method_name)
      return unless @json.show.key?(method_name.to_s)

      @json.send(method_name)
    end

    # prepared for #full_data
    # TODO: must be refactored using search
    def rank
      @json.ranks.overall.name
    end

    # prepared for #full_data
    # TODO: must be refactored using search
    def languages
      @json.ranks.languages.show.keys.join("\n")
    end

    # prepared for #full_data
    # TODO: must be refactored using search
    def total_completed
      @json.codeChallenges.totalCompleted
    end

    # parsing process
    # return hash of stats by nickname
    def json_request_parse
      uri = URI(@request)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end
  end
end
