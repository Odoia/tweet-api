require 'rails_helper'

describe ::FollowServices::Create do

  let(:subject) { ::FollowServices::Create }
  let(:user_1) { FactoryBot.create(:user, id: 1) }
  let(:user_2) { FactoryBot.create(:user, id: 2) }
  let(:invalid_user) { 5 }

  before do
    I18n.default_locale = :en
  end

  context 'When pass a invalid params' do
    context 'When use a invalid user_id' do
      it 'should be return a error menssage' do
        result = subject.new(user_id: invalid_user, follow_id: user_2.id).call
        expect(result.errors.count).to eq 1
        expect(result.errors[:user]).to eq ['must exist']
        expect(result.id.blank?).to eq true
      end
    end

    context 'When use a invalid follow_id' do
      it 'should be return a error menssage to follow' do
        result = subject.new(user_id: user_1.id, follow_id: invalid_user ).call
        expect(result.errors.count).to eq 1
        expect(result.errors[:base]).to eq ['follow user id need to be a valid id']
        expect(result.id.blank?).to eq true
      end
    end
  end

  context 'When pass a valid params' do
    context 'When use a valid user_id and follow_id' do
      it 'should be return a new user' do
        result = subject.new(user_id: user_1.id, follow_id: user_2.id).call
        expect(result.errors.count).to eq 0
        expect(result.id.blank?).to eq false
        expect(result.follow_user_id).to eq user_2.id
        expect(result.user_id).to eq user_1.id
      end
    end
  end
end
