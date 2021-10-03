class ContactsController < ApplicationController
  def index
    @succeeded_contacts = current_user.contacts.succeeded.order(created_at: :desc)
    @failed_contacts = current_user.contacts.failed.order(created_at: :desc)
  end
end
