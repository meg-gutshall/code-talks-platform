FactoryBot.define do
  factory :idea do
    title { 'Sample title' }
    description { 'Sample description' }
    user
  end
end
