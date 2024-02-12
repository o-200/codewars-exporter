module Utils
  module DownScroller
    def scroll_to_bottom_page(browser)
      loop do
        link_number = browser.links.size
        browser.scroll.to :bottom
        sleep(1)

        return browser if browser.links.size == link_number
      end
    end
  end
end
