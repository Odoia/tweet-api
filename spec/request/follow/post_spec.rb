require 'rails_helper'

describe '::Api::V1::FollowController', type: :request do

  before do
    I18n.default_locale = :en
    user_1
    user_2
    execute_actions
  end

  let(:user_1) { User.create(id: 1, name: '1user 1') }
  let(:user_2) { User.create(id: 2, name: '2user 2') }

  let(:execute_actions) {}

  context 'When send a follow' do
    context 'Whe use a valid params' do
      context 'When use a POST url' do
        let(:execute_actions) do
          post '/api/v1/follow', params: { "follow": {"userId": 1, "followUserId": 2} }, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 201' do
          expect(JSON.parse(response.body)['status']).to eq 201
        end

        it 'must be return user id' do
          expect(JSON.parse(response.body)['data']['userId']).to eq 1
        end

        it 'must be return follow user id' do
          expect(JSON.parse(response.body)['data']['followUserId']).to eq 2
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without follow' do
        let(:execute_actions) do
          post '/api/v1/follow', params: {"userId": 1, "followUserId": 2}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end

      context 'When use a body without userId' do
        let(:execute_actions) do
          post '/api/v1/follow', params: {"follow": {"followUserId": 2}}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 404' do
          expect(JSON.parse(response.body)['errors'].first['status']).to eq 404
        end

        it 'must be return id -> user' do
          expect(JSON.parse(response.body)['errors'].first['id']).to eq 'user'
        end

        it "must be return title -> must exist" do
          expect(JSON.parse(response.body)['errors'].first['title']).to eq 'must exist'
        end
      end

      context 'When use a body without followUserId' do
        let(:execute_actions) do
          post '/api/v1/follow', params: {"follow": { "userId": 1 }}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 404' do
          expect(JSON.parse(response.body)['status']).to eq 404
        end

        it 'must be return id -> follow_user_id' do
          expect(JSON.parse(response.body)['errors'].first['id']).to eq 'follow_user_id'
        end

        it "must be return title -> can't be blank" do
          expect(JSON.parse(response.body)['errors'].first['title']).to eq "can't be blank"
        end
      end

      context 'When try send a empty body' do
        let(:execute_actions) do
          post '/api/v1/follow', params: {}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end

      context 'When try send a identical id' do
        let(:execute_actions) do
          post '/api/v1/follow', params: { "follow": {"userId": 1, "followUserId": 1} }, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 404' do
          require 'pry'; binding.pry
          expect(JSON.parse(response.body)['status']).to eq 404
        end
      end
    end
  end
end
