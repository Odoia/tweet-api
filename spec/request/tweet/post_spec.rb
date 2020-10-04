require 'rails_helper'

describe '::Api::V1::TweetController', type: :request do

  before do
    I18n.default_locale = :en
    user_1
    post '/api/v1/tweet', params: params, headers: { 'ACCEPT' => 'application/json' }
  end

  let(:user_1) { FactoryBot.create(:user, id: 1) }

  let(:body) { JSON.parse response.body }

  context 'When send a tweet' do
    context 'Whe use a valid params' do
      context 'When use a POST url' do
        let(:params) { { "tweet": { "userId": 1, "message": "first tweet" } } }

        it 'must be return status 201' do
          expect(body['status']).to eq 201
        end

        it 'must be return user id 1' do
          expect(body['data']['userId']).to eq 1
        end

        it 'must be return message first tweet' do
          expect(body['data']['message']).to eq 'first tweet'
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without tweet' do
        let(:params) { { "userId": 1, "message": "first tweet" } }

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end

      context 'When use a body without userId' do
        let(:params) { { "tweet": { "message": "first tweet" } } }

        it 'must be return status 404' do
          expect(body['errors'].first['status']).to eq 404
        end

        it 'must be return id -> user_id' do
          expect(body['errors'].first['id']).to eq 'user'
        end

        it 'must be return title -> must exist' do
          expect(body['errors'].first['title']).to eq 'must exist'
        end
      end

      context 'When use a body without message' do
        let(:params) { { "tweet": {"userId": 1 } } }

        it 'must be return status 404' do
          expect(body['errors'].first['status']).to eq 404
        end

        it 'must be return id -> message' do
          expect(body['errors'].first['id']).to eq 'message'
        end

        it "must be return title -> can't be blank" do
          expect(body['errors'].first['title']).to eq "can't be blank"
        end
      end

      context 'When try send a empty body' do
        let(:params) {}

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end
    end
  end
end
