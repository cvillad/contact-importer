require 'rails_helper'

RSpec.describe ContactFiles::Create, type: :service do
  describe '#call' do
    subject(:res) { described_class.call(contact_file) }

    context 'valid content csv file' do
      let(:contact_file) { build :contact_file, file: Rack::Test::UploadedFile.new('spec/fixtures/valid_contacts.csv', 'text/csv') }

      it { expect(res.success?).to eq(true) }

      it 'creates a contact file' do
        expect { res }.to change(ContactFile, :count).by(1)
      end
    end

    context 'empty csv file' do
      let(:contact_file) { build :contact_file, file: Rack::Test::UploadedFile.new('spec/fixtures/empty_file.csv', 'text/csv') }

      it { expect(res.success?).to eq(false) }

      it { expect(res.error).to eq("Headers can't be blank") }

      it 'does not create a contact file' do
        expect { res }.not_to change(ContactFile, :count)
      end
    end
  end
end
