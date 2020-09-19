module Api
  module V1
    class FollowController < ApplicationController
      before_action :follow_params, only: [:create]

      def create
        result = create_follow
        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          error_handler
        end
      end

      private

      def follow_params
        return error_handler if params[:follow].blank?

        params.require(:follow).permit(
          :userId, :followUserId
        )
      end

      def error_handler(error: 'Bad Request', status: 400)
        render nothing: true, status: status, json: { status: status, data: error }
      end

      def create_follow
        ::Services::Follow::Create.new(user_id: follow_params['userId'], follow_id: follow_params['followUserId']).call
      end
    end
  end
end
