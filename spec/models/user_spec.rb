require 'rails_helper'

describe ::User do

  let(:user_with_follor1) { FactoryBot.create(:follow, user_id: user_1.id, follow_user_id: user_2.id) }
  let(:user_with_follor2) { FactoryBot.create(:follow, user_id: user_1.id, follow_user_id: user_3.id) }
  let(:user_with_follor3) { FactoryBot.create(:follow, user_id: user_1.id, follow_user_id: user_4.id) }
  let(:user_with_follor4) { FactoryBot.create(:follow, user_id: user_1.id, follow_user_id: user_5.id) }
  let(:user_with_follor5) { FactoryBot.create(:follow, user_id: user_6.id, follow_user_id: user_5.id) }
  let(:user_with_follor6) { FactoryBot.create(:follow, user_id: user_5.id, follow_user_id: user_6.id) }

  let(:tweet_1) { FactoryBot.create(:tweet, user_id: user_1.id) }
  let(:tweet_2) { FactoryBot.create(:tweet, user_id: user_2.id) }
  let(:tweet_22) { FactoryBot.create(:tweet, user_id: user_2.id) }
  let(:tweet_3) { FactoryBot.create(:tweet, user_id: user_3.id) }
  let(:tweet_4) { FactoryBot.create(:tweet, user_id: user_4.id) }
  let(:tweet_5) { FactoryBot.create(:tweet, user_id: user_5.id) }
  let(:tweet_6) { FactoryBot.create(:tweet, user_id: user_6.id) }

  let(:user_1) { FactoryBot.create(:user, id: 1) }
  let(:user_2) { FactoryBot.create(:user, id: 2) }
  let(:user_3) { FactoryBot.create(:user, id: 3) }
  let(:user_4) { FactoryBot.create(:user, id: 4) }
  let(:user_5) { FactoryBot.create(:user, id: 5) }
  let(:user_6) { FactoryBot.create(:user, id: 6) }

  before do
    I18n.default_locale = :en
    tweet_1
    tweet_2
    tweet_22
    tweet_3
    tweet_4
    tweet_5
    tweet_6
    user_with_follor1
    user_with_follor2
    user_with_follor3
    user_with_follor4
    user_with_follor5
    user_with_follor6
  end

  context 'When use a User model' do
    context 'When show a user 1 feed ' do
      it 'should be return a user 1 feed(users name)' do
        expect(user_1.feed.to_s).to include(user_2.name)
        expect(user_1.feed.to_s).to include(user_3.name)
        expect(user_1.feed.to_s).to include(user_4.name)
        expect(user_1.feed.to_s).to include(user_5.name)
        expect(user_1.feed.to_s).to include(tweet_22.message)
      end

      it 'should be return a user 1 feed(users messages)' do
        expect(user_1.feed.to_s).to include(tweet_2.message)
        expect(user_1.feed.to_s).to include(tweet_3.message)
        expect(user_1.feed.to_s).to include(tweet_4.message)
        expect(user_1.feed.to_s).to include(tweet_5.message)
        expect(user_1.feed.to_s).to include(tweet_1.message)
      end
    end
  end
end
