require 'rails_helper'

RSpec.describe ContactFile, type: :model do
  subject(:contact_file) { build :contact_file }

  describe '#validations' do
    it { is_expected.to be_valid }

    it { is_expected.to define_enum_for(:status).with(on_hold: 0, processing: 1, failed: 2, finished: 3) }

    it { is_expected.to validate_attached_of(:file) }

    it { is_expected.to validate_content_type_of(:file).allowing('text/csv') }

    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:contacts) }
  end
end
