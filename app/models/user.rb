class User < ApplicationRecord
  has_many :follow, class_name: '::Follow', inverse_of: :user
  has_many :tweet, class_name: '::Tweet', inverse_of: :user

  validates :name, presence: true


  def feed
    followers = find_followers_and_message
    followers.push(make_current_user_feed).flatten
  end

  private

  def find_followers_and_message
    self.follow.map do |f|
      user = User.find_by(id: f.follow_user_id)
      make_user_message_and_date_by_user(user)
    end
  end

  def make_user_message_and_date_by_user(user)
    user.tweet.map do |m|
      { name: m.user.name, message: m.message, date: m.created_at }
    end
  end

  def make_current_user_feed
    self.tweet.map do |t|
      { name: self.name, message: t.message, date: t.created_at }
    end
  end
end
