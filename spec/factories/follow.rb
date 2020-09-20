FactoryBot.define do
  factory :follow, class: '::Follow' do
    user_id { FactoryBot.create(:user) }
    follow_user_id { FactoryBot.create(:user) }
    created_at { Faker::Date.between(from: '2000-01-01', to: '2020-12-12') }
  end
end
