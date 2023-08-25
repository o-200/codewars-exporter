require 'terminal-table'

require_relative './api/profile'

file = File.open('.codewars-nick')
profile = Profile.new(file.read)

rows = [
  ['Nickname', "#{profile.username}"],
  ['Honor', "#{profile.honor}"],
  ['Profile Rank', "#{profile.rank['overall']['name']}"],
  ['Languages', "#{profile.rank['languages'].keys.reverse.join(', ')}"]
]

puts Terminal::Table.new :rows => rows
