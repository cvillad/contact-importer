require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject(:contact) { build :contact }

  describe '#validations' do
    it { is_expected.to belong_to(:contact_file) }

    it { is_expected.to define_enum_for(:status).with_values(succeeded: 0, failed: 1) }

    context 'when succeeded contact' do
      it { is_expected.to be_valid }

      it 'is invalid without attributes' do
        expect(contact).to validate_presence_of(:name)
        expect(contact).to validate_presence_of(:email)
        expect(contact).to validate_presence_of(:phone)
        expect(contact).to validate_presence_of(:date_of_birth)
      end

      it 'is invalid with invalid date format' do
        contact.date_of_birth = '12122012'
        invalid_expectation(contact, 'date_of_birth')
        contact.date_of_birth = '2012/12/06'
        invalid_expectation(contact, 'date_of_birth')
      end

      it 'is invalid with invalid phone format' do
        contact.phone = '12312'
        invalid_expectation(contact, 'phone')
        contact.phone = '(+57) 300 123 4343'
        invalid_expectation(contact, 'phone')
      end
    end
    
    context 'when failed contact' do
      subject(:contact) { build :contact, :failed }

      it { is_expected.to be_valid }

      it 'is valid without attributes' do
        expect(contact).not_to validate_presence_of(:name)
        expect(contact).not_to validate_presence_of(:email)
        expect(contact).not_to validate_presence_of(:phone)
        expect(contact).not_to validate_presence_of(:date_of_birth)
      end

      it 'is valid with invalid date format' do
        contact.date_of_birth = '12122012'
        expect(contact).to be_valid
        contact.date_of_birth = '2012/12/06'
        expect(contact).to be_valid
      end

      it 'is valid with invalid phone format' do
        contact.phone = '12312'
        expect(contact).to be_valid
        contact.phone = '(+57) 300 123 4343'
        expect(contact).to be_valid
      end
    end
  end
end
