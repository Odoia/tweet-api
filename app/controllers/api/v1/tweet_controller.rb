module Api
  module V1
    class TweetController < ApplicationController
      before_action :tweet_params, only: [:create]

      def create
        result = create_tweet
        if result.id.nil?
          error_handler(errors: result.errors, status:404 )
        else
          render status: 201, json: { data: tweet_presenter(result), status: 201 }
        end
      end

      def show
        result = feed&.sort_by { |t| t.date }
        if result
          render status: 200, json: { data: result, status: 200 }
        else
          error_handler
        end
      end

      private

      attr_reader :feed

      def tweet_params
        return error_handler if params[:tweet].blank?

        params.require(:tweet).permit(
          :message, :userId
        )
      end

      def error_handler(errors: nil, status: 400)
        render nothing: true, status: status, json: ErrorSerializer.call(errors: errors, status: status)
      end

      def feed 
        result = User.find_by(id: params['id'])&.feed
        result&.map do |u|
          ::Presenter::Feed.new(u)
        end
      end

      def create_tweet
        TweetServices::Create.new(user_id: tweet_params['userId'], message: tweet_params['message']).call
      end

      def tweet_presenter(result)
        ::Presenter::Tweet.new(result)
      end
    end
  end
end
