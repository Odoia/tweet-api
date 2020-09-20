class Follow < ApplicationRecord
  belongs_to :user, class_name: '::User'

  validates :user_id, presence: true
  validates_with ::Util::FollowValidate
  validates :follow_user_id, presence: true
end
