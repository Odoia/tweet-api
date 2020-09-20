module Presenter
  class User
    attr_reader :id, :name, :created_at

    def initialize(attrs)
      @id         = attrs[:id]
      @name       = attrs[:name]
      @createdAt  = attrs[:created_at]
    end
  end
end
