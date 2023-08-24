require_relative './api/profile'

file = File.open('.codewars-nick')
profile = Profile.new(file.read)
