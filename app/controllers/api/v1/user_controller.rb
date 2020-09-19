module Api
  module V1
    class UserController < ApplicationController
      before_action :user_params, only: [:create]

      def create
        result = create_user
        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          error_handler
        end
      end

      private

      def user_params
        return error_handler if params[:user].blank?

        params.require(:user).permit(:name)
      end

      def error_handler(error: 'Bad Request', status: 400)
        render nothing: true, status: status, json: { status: status, data: error }
      end

      def create_user
        ::Services::User::Create.new(name: user_params['name']).call
      end
    end
  end
end
