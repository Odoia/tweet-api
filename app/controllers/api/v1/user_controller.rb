module Api
  module V1
    class UserController < ApplicationController
      before_action :user_params, only: [:create]

      def create
        result = create_user
        unless result.id.nil?
          render status: 201, json: { data: user_presenter(result), status: 201 }
        else
          error_handler(errors: result.errors, status:404 )
        end
      end

      private

      def user_params
        return error_handler if params[:user].blank?

        params.require(:user).permit(:name)
      end

      def error_handler(errors: nil, status: 400)
        render nothing: true, status: status, json: ErrorSerializer.call(errors: errors, status: status)
      end

      def create_user
        ::Services::User::Create.new(name: user_params['name']).call
      end

      def user_presenter(result)
        ::Presenter::User.new(result)
      end
    end
  end
end
