require 'rails_helper'

describe '::Api::V1::UserController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:execute_actions) {}

  context 'When create a user' do
    context 'Whe use a valid params' do
      context 'When use a POST url' do
        let(:execute_actions) do
          post '/api/v1/user', params: { "user": {"name": "user name"} }, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 201' do
          expect(JSON.parse(response.body)['status']).to eq 201
        end

        it 'must be return user name' do
          expect(JSON.parse(response.body)['data']['name']).to eq 'user name'
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without user' do
        let(:execute_actions) do
          post '/api/v1/user', params: {"name": "user name"}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end

      context 'When use a body without name' do
        let(:execute_actions) do
          post '/api/v1/user', params: {"user": {}}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end

      context 'When try send a empty body' do
        let(:execute_actions) do
          post '/api/v1/user', params: {}, headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 400' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end
    end
  end
end
