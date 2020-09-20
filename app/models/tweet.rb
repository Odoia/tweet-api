class Tweet < ApplicationRecord
  belongs_to :user, class_name: '::User'

  validates :user_id, :message, presence: true
end
