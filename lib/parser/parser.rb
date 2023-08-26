require 'nokogiri'
require 'watir'
require 'open-uri'

browser = Watir::Browser.new
# browser = Watir::Browser.new(url: "https://www.codewars.com/users/o-200/completed_solutions")

# doc = Nokogiri::HTML.parse(browser)

# item_list = doc.css('section.user-profile')

# item_list.each do |title|
#   puts title
# end


# url = "https://www.codewars.com/users/o-200/completed_solutions"
# html = URI::open(url) { |result| result.read }

# doc = Nokogiri::HTML(html)

# item_list = doc.css('section.user-profile')

# item_list.each do |title|
#   puts title
# end

# binding.irb


#todo - check how to read render after fully load
