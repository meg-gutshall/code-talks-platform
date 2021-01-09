FactoryBot.define do
  factory :idea do
    user

    title { 'Sample title' }
    description { 'Sample description' }
  end
end
