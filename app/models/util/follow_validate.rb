module Util
  class FollowValidate < ActiveModel::Validator

    def validate(record)
      if User.find_by(id: record.follow_user_id).blank?
        record.errors[:base] << I18n.t('valid_id')
      end

      unless record.user_id != record.follow_user_id
        record.errors[:base] << I18n.t('different_id')
      end
    end
  end
end
