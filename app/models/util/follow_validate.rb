module Util
  class FollowValidate < ActiveModel::Validator

    def validate(record)
      unless record.user_id != record.follow_user_id
        record.errors[:base] << 'user id needs to be different from follow user id'
      end
    end

  end
end
