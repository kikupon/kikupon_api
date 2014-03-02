class AccountAPI < Grape::API
  format :json
  formatter :json, Grape::Formatter::Rabl

  # API prefix
  # ex) http://localhost:3000/a
  prefix "a"

  # API version
  # ex) http://localhost:3000/a/v1
  version 'v1', :using => :path

  before do
    Mongoid.load!('mongoid.yml', :development)
  end

  resource "create_account_by_tw" do
    # ex) http://localhost:3000/a/v1/create_account
    desc "create account with twitter"
    params do
        requires :tw_id, type: Integer, desc: "twitter id"
    end

    get do
        user = User.new

        return "aa"
    end
  end

  resource "create_account_by_fb" do
    # ex) http://localhost:3000/a/v1/create_account
    desc "create account with facebook"
    params do
        requires :fb_id, type: Integer, desc: "twitter id"
        optional :sex, type: Boolean
        optional :birthday, type: Time
        optional :pref, type: String
        optional :drink_flag, type: Integer
        optional :love_genres, type: String
        optional :dis_genres, type: String
        optional :morning_amt_min, type: Integer
        optional :morning_amt_max, type: Integer
        optional :morning_amt_avg, type: Integer
        optional :lunch_amt_min, type: Integer
        optional :lunch_amt_max, type: Integer
        optional :lunch_amt_avg, type: Integer
        optional :dinner_amt_min, type: Integer
        optional :dinner_amt_max, type: Integer
        optional :dinner_amt_avg, type: Integer
    end

    get do
        if User.where(:fb_id => params[:fb_id]).exists?
            return {:status => "error"}
        end
        user = User.new({:fb_id           => params[:fb_id],
                         :sex             => params[:sex],
                         :birthday        => params[:birthday],
                         :pref            => params[:pref],
                         :drink_flag      => params[:drink_flag],
                         :love_genres     => params[:love_genres] && params[:love_genres].split(","),
                         :dis_genres      => params[:dis_genres] && params[:dis_genres].split(","),
                         :morning_amt_min => params[:morning_amt_min],
                         :morning_amt_max => params[:morning_amt_max],
                         :morning_amt_avg => params[:morning_amt_avg],
                         :lunch_amt_min   => params[:lunch_amt_min],
                         :lunch_amt_max   => params[:lunch_amt_max],
                         :lunch_amt_avg   => params[:lunch_amt_avg],
                         :dinner_amt_min  => params[:dinner_amt_min],
                         :dinner_amt_max  => params[:dinner_amt_max],
                         :dinner_amt_avg  => params[:dinner_amt_avg],
        })
        user.save!
        return {:status => "success",
                :id     => user.id.to_s,
                :user   => user,
               }
    end
  end

  resource "get_account" do
    # ex) http://localhost:3000/a/v1/create_account
    desc "get account info"
    params do
        requires :id, type: String, desc: "twitter id"
    end

    get do
        p User.where(:_id => params[:id]).first
    end
  end
end
