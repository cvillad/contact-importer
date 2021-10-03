FactoryBot.define do
  factory :contact_file do
    columns { {  } }
    file { CsvHandler.load('spec/fixtures/valid_contacts.csv') }
    headers { ['test-header'] }
    association :user

    trait :no_headers do
      headers { nil }
    end
  end
end
