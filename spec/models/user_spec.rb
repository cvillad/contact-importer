require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build :user }

  describe '#validations' do
    it { is_expected.to be_valid }

    it 'is invalid without attributes' do
      expect(user).to validate_presence_of(:email)
      expect(user).to validate_presence_of(:password)
    end
  end
end
