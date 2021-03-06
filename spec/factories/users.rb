FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence :email do |n|
      "test#{n}@example.com"
    end

    password { User.new.send(:password_digest, '12345678') }
    encrypted_password { User.new.send(:password_digest, '12345678') }
  end
end
