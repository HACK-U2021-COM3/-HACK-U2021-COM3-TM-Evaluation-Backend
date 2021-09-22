FactoryBot.define do

  factory :user do
    uid { |n| "TEST_UID_#{n}" }
  end

  factory :past_plan do
    sequence(:title){ |n| "TEST_TITLE_#{n}" }
    sequence(:sum_time){ |n| n * 10}
    association :user
  end

end
