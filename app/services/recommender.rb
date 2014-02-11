class Recommender
  def initialize(restaurants, user, geo=nil)
    @restaurants = restaurants
    @user = user
    @geo = geo
  end

  def recommend
    # validation
    if @restaurants.blank?
      return Array.new()
    end

    # TODO impliment restaurants filter

    # switch scoring logic according to rests/user/geo/time information
    logic = BasicScoringLogic.new(@user)

    # scoring each restaurants and return top 30
    @restaurants.map { |restaurant|
      restaurant.score = logic.scoring(restaurant)
    }
    @restaurants.sort_by! { |restaurant| -1 * restaurant.score }
    if @restaurants.size <= API_RESPONSE_MAX
      return @restaurants
    else
      return @restaurants.slice![0..API_RESPONSE_MAX]
    end
  end
end

