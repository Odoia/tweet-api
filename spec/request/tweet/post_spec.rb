require 'rails_helper'

describe '::Api::V1::TweetController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:execute_actions) {}

  context 'When send a tweet' do
    context 'Whe use a valid params' do
      context 'When use a POST url' do
        let(:execute_actions) do
          post '/api/v1/tweet', params: { "tweet": {"userId": 1, "message": "first tweet"} }, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 201' do
          expect(JSON.parse(response.body)['status']).to eq 201
        end

        it 'must be return user id 1' do
          expect(JSON.parse(response.body)['data']['user_id']).to eq 1
        end

        it 'must be return message first tweet' do
          expect(JSON.parse(response.body)['data']['message']).to eq 'first tweet'
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without tweet' do
        let(:execute_actions) do
          post '/api/v1/tweet', params: {"userId": 1, "message": "first tweet"}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end

      context 'When use a body without userId' do
        let(:execute_actions) do
          post '/api/v1/tweet', params: {"tweet": {"message": "first tweet"}}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 404' do
          expect(JSON.parse(response.body)['errors'].first['status']).to eq 404
        end

        it 'must be return id -> user_id' do
          expect(JSON.parse(response.body)['errors'].first['id']).to eq 'user_id'
        end

        it "must be return title -> can't be blank" do
          expect(JSON.parse(response.body)['errors'].first['title']).to eq "can't be blank"
        end
      end

      context 'When use a body without message' do
        let(:execute_actions) do
          post '/api/v1/tweet', params: {"tweet": { "userId": 1 }}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 404' do
          expect(JSON.parse(response.body)['errors'].first['status']).to eq 404
        end

        it 'must be return id -> message' do
          expect(JSON.parse(response.body)['errors'].first['id']).to eq 'message'
        end

        it "must be return title -> can't be blank" do
          expect(JSON.parse(response.body)['errors'].first['title']).to eq "can't be blank"
        end
      end

      context 'When try send a empty body' do
        let(:execute_actions) do
          post '/api/v1/tweet', params: {}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end
    end
  end
end
