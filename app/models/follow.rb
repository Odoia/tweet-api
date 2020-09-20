class Follow < ApplicationRecord
  validates :user_id, :follow_user_id, presence: true
end
