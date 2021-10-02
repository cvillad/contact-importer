require 'rails_helper'

RSpec.describe ContactFilesController, type: :controller do
  let(:user) { create :user }

  describe '#index' do
    subject { get :index }

    context 'user signed in' do
      include_context 'sign in user'

      it { is_expected.to have_http_status(:success) }
    end

    context 'user not signed in' do
      it_behaves_like 'unauthenticated actions'
    end
  end
end