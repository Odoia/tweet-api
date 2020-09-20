module Presenter
  class Follow
    attr_reader :id, :user_id, :follow_user_id, :created_at

    def initialize(attrs)
      @id           = attrs[:id]
      @userId       = attrs[:user_id]
      @followUserId = attrs[:follow_user_id]
      @createdAt    = attrs[:created_at]
    end
  end
end
