module Api
  module V1
    class TweetController < ApplicationController

      def create
        result = create_tweet
        render status: 201, json: { data: result ,status: 201 }
      end

      private

      def create_tweet
        ::Services::Tweet::Create.new(user_id: params['userId'], message: params['tweet']).call
      end

    end
  end
end
