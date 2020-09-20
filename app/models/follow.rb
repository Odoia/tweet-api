class Follow < ApplicationRecord
  belongs_to :user, class_name: '::User'

  validates :user_id, :follow_user_id, presence: true
end
