require 'rails_helper'

shared_examples_for 'unauthenticated actions' do
  it 'redirects to sign in path' do
    expect(subject).to have_http_status(:redirect)
    expect(subject).to redirect_to('/users/sign_in')
  end
end