class User < ApplicationRecord
  has_many :follow, class_name: '::Follow', inverse_of: :user

  validates :name, presence: true
end
