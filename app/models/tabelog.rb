module Tabelog
  def self.get_additional_info_with_clawler(restaurant)
    # TOOO retry or tuning?
    rating = -1
    begin
      # get tabelog rating with clawler
      Masque.run(:driver => :webkit) do
        visit "http://www.google.com/"
        fill_in("q", :with => "食べログ" + restaurant.name + " " + restaurant.address)
        find('*[name="btnG"]').click
        contents = Nokogiri::HTML(page.html)
        target_string = contents.css('.slp')[0].to_s
        rating = target_string.match(/評価: ([0-5].?[1-9]?).-/)[1]
      end
    rescue
      # if cannot get tabelog rating, rating will be -1
      rating = -1
    end
    restaurant.tabelog_rating = rating.to_d
    return restaurant
  end
end
