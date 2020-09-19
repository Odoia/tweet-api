module Services
  module User
    class Create
      def initialize(name:)
        @name = name
      end

      def call
        tweet_create
      end

      private

      attr_reader :name

      def tweet_create
        result = ::User.new(params_to_save)
        result.save
        result
      end

      def params_to_save
        {
          name: name
        }
      end
    end
  end
end
