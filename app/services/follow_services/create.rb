module FollowServices
  class Create
    def initialize(user_id:, follow_id:)
      @user_id        = user_id
      @follow_user_id = follow_id
    end

    def call
      follow_create
    end

    private

    attr_reader :user_id, :follow_user_id

    def follow_create
      ::Follow.new.tap do |f|
        f.user_id = user_id
        f.follow_user_id = follow_user_id
        f.save
      end
    end
  end
end
