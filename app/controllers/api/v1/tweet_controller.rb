module Api
  module V1
    class TweetController < ApplicationController
      
      def create
        ::Tweet.new(
          userId: params['userId'], message: params['tweet']
        )
      end
      
    end
  end
end
