FactoryBot.define do
  factory :contact_file do
    columns { {  } }
    file { CsvHandler.load('spec/fixtures/valid_contacts.csv') }

    association :user
  end
end
