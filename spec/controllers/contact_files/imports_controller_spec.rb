require 'rails_helper'

RSpec.describe ContactFiles::ImportsController, type: :controller do
  let(:user) { create :user }
  let(:contact_file) { create :contact_file, user: user  }

  describe '#new' do
    subject { get :new, params: { contact_file_id: contact_file } }

    context 'user signed in' do
      include_context 'sign in user'

      it { is_expected.to have_http_status(:success) }
    end

    context 'user not signed in' do
      it_behaves_like 'unauthenticated actions'
    end
  end

  describe '#create' do
    subject(:req) { post :create, params: { contact_file_id: contact_file, import: import_params } }

    let(:import_params) { { name: 'full_name', email: 'email', phone: 'phone', addres: 'address', date_of_birth: 'date_of_birth' } }

    context 'user signed in' do
      include_context 'sign in user'

      it { is_expected.to have_http_status(:found) }

      it { is_expected.to redirect_to(contact_files_path) }
    end

    context 'user not signed in' do
      it_behaves_like 'unauthenticated actions'
    end
  end
end
