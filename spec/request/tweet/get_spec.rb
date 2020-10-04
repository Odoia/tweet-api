require 'rails_helper'

describe '::Api::V1::TweetController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
    get '/api/v1/tweet/1', params: {}, headers: { 'ACCEPT' => 'application/json' }
  end

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

  let(:execute_actions) {}
  let(:body) { JSON.parse response.body }

  context 'When get a tweet feed' do
    context 'Whe use a valid params' do
      context 'When use a Get url' do
        let(:execute_actions) do
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

        it 'must be return status 200' do
          expect(JSON.parse(response.body)['status']).to eq 200
        end

        it 'must be user 1 data' do
          expect(body['data'].to_s).to include(tweet_1.message)
          expect(body['data'].to_s).to include(user_1.name)
        end

        it 'must be user 2 data' do
          expect(body['data'].to_s).to include(tweet_2.message)
          expect(body['data'].to_s).to include(user_2.name)
        end

        it 'must be user 2 second message' do
          expect(body['data'].to_s).to include(tweet_22.message)
          expect(body['data'].to_s).to include(user_2.name)
        end

        it 'must be user 3 data' do
          expect(body['data'].to_s).to include(tweet_3.message)
          expect(body['data'].to_s).to include(user_3.name)
        end

        it 'must be user 4 data' do
          expect(body['data'].to_s).to include(tweet_4.message)
          expect(body['data'].to_s).to include(user_4.name)
        end

        it 'must be user 5 data' do
          expect(body['data'].to_s).to include(tweet_5.message)
          expect(body['data'].to_s).to include(user_5.name)
        end

        it 'must not contain be user 6 data' do
          expect(body['data'].to_s).not_to include(user_6.name)
          expect(body['data'].to_s).not_to include(tweet_6.message)
        end
      end
    end
    context 'Whe use a valid params' do
      context 'When use a Get url' do
        it 'must be return status 200' do
          expect(body['status']).to eq 400
        end
      end
    end
  end
end
