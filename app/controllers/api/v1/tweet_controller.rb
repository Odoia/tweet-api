module Api
  module V1
    class TweetController < ApplicationController
      before_action :tweet_params, only: [:create]

      def create
        result = create_tweet
        unless result.id.nil?
          render status: 201, json: { data: tweet_presenter(result), status: 201 }
        else
          error_handler(errors: result.errors, status:404 )
        end
      end

      def show
        require 'pry'; binding.pry
        
      end

      private

      def tweet_params
        return error_handler if params[:tweet].blank?

        params.require(:tweet).permit(
          :message, :userId
        )
      end

      def error_handler(errors: nil, status: 400)
        render nothing: true, status: status, json: ErrorSerializer.call(errors: errors, status: status)
      end

      def create_tweet
        ::Services::Tweet::Create.new(user_id: tweet_params['userId'], message: tweet_params['message']).call
      end

      def tweet_presenter(result)
        ::Presenter::Tweet.new(result)
      end
    end
  end
end
