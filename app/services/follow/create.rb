module Services
  module Follow
    class Create
      def initialize(user_id:, follow_id:)
        @user_id        = user_id
        @follow_user_id = follow_id
      end

      def call
        follow_create
      end

      private

      attr_reader :user_id, :follow_user_id

      def follow_create
        result = ::Follow.new(params_to_save)
        result.save
        follow_presenter(result)
      end

      def params_to_save
        {
          user_id: user_id,
          follow_user_id: follow_user_id
        }
      end

      def follow_presenter(result)
        ::Presenter::Follow.new(result)
      end
    end
  end
end
