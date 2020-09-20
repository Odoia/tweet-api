require 'rails_helper'

describe '::Api::V1::TweetController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:execute_actions) {}

  context 'When get a tweet feed' do
    context 'Whe use a valid params' do
      context 'When use a Get url' do
        let(:execute_actions) do
          get '/api/v1/tweet/1', headers: { 'ACCEPT' => 'application/json' }
        end

        it 'must be return status 200' do
          expect(JSON.parse(response.body)['status']).to eq 200
        end
      end
    end
  end
end
