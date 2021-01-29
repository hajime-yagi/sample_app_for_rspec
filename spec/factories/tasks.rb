FactoryBot.define do
  factory :task do
    sequence(:title, "title_1")
    content  { "テストです" }
    status   { :todo }
    deadline  { 1.day.from_now }
    association :user
  end
end
