module Api
  module V1
    class TweetController < ApplicationController
      
      def create
        result = ::Tweet.new(
          user_id: params['userId'], message: params['tweet']
        )
        result.save
        render status: 201, json: { data: result ,status: 201 }
      end
      
    end
  end
end
