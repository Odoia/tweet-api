module Api
  module V1
    class FollowController < ApplicationController
      include ErrorSerializer
      before_action :follow_params, only: [:create]

      def create
        result = create_follow
        if result.id.nil?
          error_handler(errors: result.errors, status:404 )
        else
          render status: 201, json: { data: follow_presenter(result), status: 201 }
        end
      end

      private

      def follow_params
        return error_handler if params[:follow].blank?

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

      def follow_presenter(result)
        ::Presenter::Follow.new(result)
      end
    end
  end
end
