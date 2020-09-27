require 'rails_helper'

describe ::UserServices::Create do

  let(:subject) { ::UserServices::Create }
  let(:name) { Faker::Name.name }


  before do
    I18n.default_locale = :en
  end

  context 'When pass a invalid users' do
    context 'When register a invalid user_id' do
      it 'should be retaurn a error menssage' do
        result = subject.new(name: nil ).call
        expect(result.errors.count).to eq 1
        expect(result.errors[:name]).to eq ["can't be blank"]
        expect(result.id.blank?).to eq true
      end
    end
  end

  context 'When pass a valid user' do
    it 'should be return a new tweet' do
      result = subject.new(name: name ).call
      expect(result.errors.count).to eq 0
      expect(result.id.blank?).to eq false
      expect(result.name).to eq name
    end
  end
end
