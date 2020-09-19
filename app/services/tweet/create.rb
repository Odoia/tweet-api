module Services
  module Tweet
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
        result = ::Tweet.new(params_to_save)
        result.save
        result
      end

      def params_to_save
        {
          message: message,
          user_id: user_id
        }
      end

    end
  end
end
