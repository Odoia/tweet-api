class Follow < ApplicationRecord
  belongs_to :user, class_name: '::User'

  validates :user_id, presence: true
  validates_with ::Util::FollowValidate
  validates :follow_user_id, presence: true, if: :follow_validate?

  def follow_validate?
    User.find_by(id: follow_user_id).blank?
  end
end
