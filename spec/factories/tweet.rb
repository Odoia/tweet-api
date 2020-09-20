FactoryBot.define do
  factory :tweet, class: '::Tweet' do
    user_id { FactoryBot.create(:user) }
    message { Faker::Lorem.sentence }
    created_at { Faker::Date.between(from: '2000-01-01', to: '2020-12-12') }
  end
end
