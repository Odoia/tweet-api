module Api
  module V1
    class FollowController < ApplicationController
      include ErrorSerializer
      before_action :follow_params, only: [:create]

      def create
        result = create_follow
        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          error_handler(errors: result.errors, status:404 )
        end
      end

      private

      def follow_params
        return error_handler if params[:follow].blank?

        return error_handler(status: 404) if params['follow']['userId'] == params['follow']['followUserId']

        params.require(:follow).permit(
          :userId, :followUserId
        )
      end

      def error_handler(errors: nil, status: 400)
        render nothing: true, status: status, json: ErrorSerializer.call(errors: errors, status: status)
      end

      def create_follow
        ::Services::Follow::Create.new(user_id: follow_params['userId'], follow_id: follow_params['followUserId']).call
      end
    end
  end
end
