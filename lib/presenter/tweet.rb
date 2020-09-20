module Presenter
  class Tweet
    attr_reader :id, :message, :user_id, :created_at

    def initialize(attrs)
      @id         = attrs[:id]
      @message    = attrs[:message]
      @userId     = attrs[:user_id]
      @createdAt  = attrs[:created_at]
    end
  end
end
