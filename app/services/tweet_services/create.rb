module TweetServices
  class Create
    def initialize(user_id:, message:)
      @user_id  = user_id
      @message  = message
    end

    def call
      tweet_create
    end

    private

    attr_reader :message, :user_id

    def tweet_create
      ::Tweet.new.tap do |t|
        t.message = message
        t.user_id = user_id
        t.save
      end
    end
  end
end
