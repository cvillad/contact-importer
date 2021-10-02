FactoryBot.define do
  factory :contact do
    sequence(:email) { |n| "jdoe-#{n}@example.com" }
    name { 'sample-name' }
    date_of_birth { '1999-10-02' }
    phone { '(+57) 122 324 12 14' }
    address { 'Calle lagartos 75' }
    credit_card { '4242424242424242' }
    
    association :contact_file

    trait :failed do
      email { 'sample-email'}
      name { nil }
      date_of_birth { '1999/10/02' }
      phone { nil }
      address { nil }
      credit_card { nil }
      status { :failed }
    end
  end
end
