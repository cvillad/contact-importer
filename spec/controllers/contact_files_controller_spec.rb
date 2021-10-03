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

  describe '#create' do
    subject(:req) { post :create, params: params }

    let(:params) { { contact_file: { file: nil } } }

    context 'user signed in' do
      include_context 'sign in user'

      context 'param provided' do
        let(:params) do
          { contact_file: { file: Rack::Test::UploadedFile.new('spec/fixtures/valid_contacts.csv', 'text/csv') } }
        end

        it { is_expected.to have_http_status(:found) }

        it { is_expected.to redirect_to(new_contact_file_import_path(ContactFile.last)) }

        it { expect{ req }.to change(user.contact_files, :count).by(1) }
      end

      context 'no params provided' do
        it { is_expected.to have_http_status(:found) }

        it { is_expected.to redirect_to(contact_files_path) }

        it { expect{ req }.not_to change(user.contact_files, :count) }
      end
    end

    context 'user not signed in' do
      it_behaves_like 'unauthenticated actions'
    end
  end

  describe '#destroy' do
    subject(:req) { delete :destroy, params: { id: contact_file.id } }

    let(:contact_file) { create :contact_file, user: user }

    context 'user signed in' do
      include_context 'sign in user'

      before { contact_file }

      it { is_expected.to have_http_status(:found) }

      it { is_expected.to redirect_to(contact_files_path) }

      it 'deletes a contact file' do
        expect{ req }.to change(user.contact_files, :count).by(-1)
      end
    end

    context 'user not signed in' do
      it_behaves_like 'unauthenticated actions'
    end
  end
end