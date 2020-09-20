module Util
  class FollowValidate < ActiveModel::Validator

    def validate(record)
      if User.find_by(id: record.follow_user_id).blank?
        record.errors[:base] << 'follow user id need to be a valid id'
      end

      unless record.user_id != record.follow_user_id
        record.errors[:base] << 'user id needs to be different from follow user id'
      end
    end
  end
end
