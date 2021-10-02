require 'rails_helper'

shared_context 'sign in user' do
  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
  end
end
