class UserRegister
    def initialize
        Mongoid.load!("mongoid.yml")
    end
    def create_account_by_tw user
        user = User.new({:user_id => data[:user_id],
                         :fb_id   => data[:fb_id],
                         :tw_id   => nil,

                        }
                       )
        user.save!
    end
    def create_account_by_fb data
        user = User.new({:user_id => 1,
                         :fb_id   => nil,
                         :tw_id   => 33,
                        }
                       )
        user.save!
    end
end
