require './lib/api/profile'

puts "input your name from codewars nickname"
nick = gets.chomp.to_s

profile = Profile.new(nick)

puts profile.username
puts profile.honor
puts profile.rank
