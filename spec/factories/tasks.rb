FactoryBot.define do
  factory :task do
    sequence(:title, "title_1")
    content  { "テストです" }
    status   { :Todo }
    deadline  { 1.day.from_now }
    association :user
  end
end
