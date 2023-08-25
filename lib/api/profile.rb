require 'net/http'
require 'json'

class Profile
  def initialize(nick)
    @request = "https://www.codewars.com/api/v1/users/#{nick}"
    @json = json_parse
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

  def json_parse
    uri = URI(@request)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

