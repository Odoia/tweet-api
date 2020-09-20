module Presenter
  class Feed
    attr_reader :name, :message, :date

    def initialize(attrs)
      @name     = attrs[:name]
      @message  = attrs[:message]
      @date     = attrs[:date]
    end
  end
end
