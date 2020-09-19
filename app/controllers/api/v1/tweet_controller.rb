module Api
  module V1
    class TweetController < ApplicationController
      before_action :tweet_params, only: [:create]

      def create
        result = create_tweet
        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          error_handler
        end
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
    end
  end
end
