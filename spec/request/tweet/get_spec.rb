require 'rails_helper'

describe '::Api::V1::TweetController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:user_with_follor1) { Follow.create(user_id: user_1.id, follow_user_id: user_2.id) }
  let(:user_with_follor2) { Follow.create(user_id: user_1.id, follow_user_id: user_3.id) }
  let(:user_with_follor3) { Follow.create(user_id: user_1.id, follow_user_id: user_4.id) }
  let(:user_with_follor4) { Follow.create(user_id: user_1.id, follow_user_id: user_5.id) }
  let(:user_with_follor5) { Follow.create(user_id: user_6.id, follow_user_id: user_5.id) }
  let(:user_with_follor6) { Follow.create(user_id: user_5.id, follow_user_id: user_6.id) }

  let(:tweet_1) { Tweet.create(user_id: user_1.id, message: 'user 1', created_at: Date.today()) }
  let(:tweet_2) { Tweet.create(user_id: user_2.id, message: 'user 2', created_at: Date.today() + 1) }
  let(:tweet_22) { Tweet.create(user_id: user_2.id, message: 'user 22', created_at: Date.today() + 2) }
  let(:tweet_3) { Tweet.create(user_id: user_3.id, message: 'user 3', created_at: Date.today() + 3) }
  let(:tweet_4) { Tweet.create(user_id: user_4.id, message: 'user 4', created_at: Date.today() + 4) }
  let(:tweet_5) { Tweet.create(user_id: user_5.id, message: 'user 5', created_at: Date.today() + 5) }
  let(:tweet_6) { Tweet.create(user_id: user_6.id, message: 'user 6', created_at: Date.today() + 6) }

  let(:user_1) { User.create(id: 1, name: '1user 1') }
  let(:user_2) { User.create(id: 2, name: '2user 2') }
  let(:user_3) { User.create(id: 3, name: '3user 3') }
  let(:user_4) { User.create(id: 4, name: '4user 4') }
  let(:user_5) { User.create(id: 5, name: '5user 5') }
  let(:user_6) { User.create(id: 6, name: '6user 6') }

  let(:execute_actions) {}

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

          get '/api/v1/tweet/1', params: {}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 200' do
          require 'pry'; binding.pry
          expect(JSON.parse(response.body)['status']).to eq 200
        end
      end
    end
  end
end
