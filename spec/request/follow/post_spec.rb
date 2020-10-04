require 'rails_helper'

describe '::Api::V1::FollowController', type: :request do

  before do
    I18n.default_locale = :en
    user_1
    user_2
    post '/api/v1/follow', params: params, headers: { 'ACCEPT' => 'application/json' }
  end

  let(:user_1) { FactoryBot.create(:user, id: 1) }
  let(:user_2) { FactoryBot.create(:user, id: 2) }

  let(:body) { JSON.parse response.body }

  context 'When send a follow' do
    context 'Whe use a valid params' do
      context 'When use a POST url' do
        let(:params) { { "follow": { "userId": 1, "followUserId": 2 } } }

        it 'must be return status 201' do
          expect(body['status']).to eq 201
        end

        it 'must be return user id' do
          expect(body['data']['userId']).to eq 1
        end

        it 'must be return follow user id' do
          expect(body['data']['followUserId']).to eq 2
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without follow' do
        let(:params) { { "userId": 1, "followUserId": 2 } }

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end

      context 'When use a body without userId' do
        let(:params) { { "follow": { "followUserId": 2 } } }

        it 'must be return status 404' do
          expect(body['errors'].first['status']).to eq 404
        end

        it 'must be return id -> user' do
          expect(body['errors'].first['id']).to eq 'user'
        end

        it 'must be return title -> must exist' do
          expect(body['errors'].first['title']).to eq 'must exist'
        end
      end

      context 'When use a body without followUserId' do
        let(:params) { {"follow": { "userId": 1 } } }

        it 'must be return status 404' do
          expect(body['errors'].first['status']).to eq 404
        end

        it 'must be return id -> base' do
          expect(body['errors'].first['id']).to eq 'base'
        end

        it 'must be return title -> follow user id need to be a valid id' do
          expect(body['errors'].first['title']).to eq 'follow user id need to be a valid id'
        end
      end

      context 'When try send a empty body' do
        let(:params) {}

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end

      context 'When try send a identical id' do
        let(:params) { { "follow": { "userId": 1, "followUserId": 1 } } }

        it 'must be return status 404' do
          expect(body['errors'].first['status']).to eq 404
        end

        it 'must be show base error' do
          expect(body['errors'].first['title']).to eq 'user id needs to be different from follow user id'
        end
      end
    end
  end
end
