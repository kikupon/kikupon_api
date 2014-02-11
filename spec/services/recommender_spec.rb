require 'spec_helper'

describe Recommender do
  it "return recommended restaurants Array" do
    # TODO should use stab to separate test layer
    lat = 35.664035231
    lng = 139.70785100000001
    range = 1
    restaurants = RestaurantsGetter.get(lat, lng, range)

    user = User.new
    recommender = Recommender.new(restaurants, user)
    sorted_restaurants = recommender.recommend

    # at least more htan one
    expect(sorted_restaurants.size).to be >= 1

    # restaurants are sorted by score
    score_array = Array.new
    sorted_restaurants.each { |sorted_restaurant| score_array << sorted_restaurant.score }
    for i in 0..score_array.size-2
      expect(score_array[i]).to be >= score_array[i+1]
    end
  end
end
