require 'rails_helper'

RSpec.describe ContactFiles::Import, type: :service do
  describe '#call' do
    subject(:res) { described_class.call(contact_file, headers) }

    let(:headers) { {name: "full_name", email: "email_address", date_of_birth: "date_of birth", phone: "cellphone", address: " address", credit_card: "credit_card_number"} }
    let(:contact_file) { create :contact_file, file: CsvHandler.load('spec/fixtures/contacts.csv') }
    
    it { expect(res.success?).to eq(true) }

    it { expect(res.succeeded.count).to eq(3) }

    it { expect(res.failed.count).to eq(1) }
end
end