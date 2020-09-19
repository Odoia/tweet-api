module Api
  module V1
    class TweetController < ApplicationController

      def create
        result = create_tweet
        render status: 201, json: { data: result, status: 201 }
      end

      private

      def tweet_params
        params.require(:tweet).permit(
          :message, :userId
        )
      end

      def create_tweet
        ::Services::Tweet::Create.new(user_id: tweet_params['userId'], message: tweet_params['message']).call
      end
    end
  end
end
