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
    @json['ranks']
  end

  private

  def json_parse
    uri = URI(@request)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
