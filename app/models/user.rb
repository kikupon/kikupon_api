class User
  include Mongoid::Document
  field :fb_id, type: String
  field :tw_id, type: String
  field :sex, type: Mongoid::Boolean
  field :birthday, type: Time
  field :pref, type: String
  field :drink_flag, type: Integer
  field :love_genres, type: Array
  field :dis_genres, type: Array
  field :morning_amt_min, type: Integer
  field :morning_amt_max, type: Integer
  field :morning_amt_avg, type: Integer
  field :lunch_amt_min, type: Integer
  field :lunch_amt_max, type: Integer
  field :lunch_amt_avg, type: Integer
  field :dinner_amt_min, type: Integer
  field :dinner_amt_max, type: Integer
  field :dinner_amt_avg, type: Integer
end
