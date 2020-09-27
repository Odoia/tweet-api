require 'rails_helper'

describe ::TweetServices::Create do

  let(:subject) { ::TweetServices::Create }
  let(:user_1) { FactoryBot.create(:user, id: 1) }
  let(:invalid_user) { 5 }
  let(:message) { Faker::Lorem.sentence }


  before do
    I18n.default_locale = :en
  end

  context 'When pass a invalid users' do
    context 'When register a invalid user_id' do
      it 'should be retaurn a error menssage' do
        result = subject.new(user_id: invalid_user, message: message).call
        expect(result.errors.count).to eq 1
        expect(result.errors[:user]).to eq ['must exist']
        expect(result.id.blank?).to eq true
      end
    end

    context 'When register a nil message' do
      it 'should be retaurn a error menssage' do
        result = subject.new(user_id: user_1.id, message: nil).call
        expect(result.errors.count).to eq 1
        expect(result.errors[:message]).to eq ["can't be blank"]
        expect(result.id.blank?).to eq true
      end
    end
  end

  context 'When pass a valid user' do
    it 'should be return a new tweet' do
      result = subject.new(user_id: user_1.id , message: message).call
      expect(result.errors.count).to eq 0
      expect(result.id.blank?).to eq false
      expect(result.message).to eq message
      expect(result.user_id).to eq user_1.id
    end
  end
end
