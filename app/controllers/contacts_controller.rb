class ContactsController < ApplicationController
  def index
    @succeeded_contacts = current_user.contacts.succeeded
    @failed_contacts = current_user.contacts.failed
  end
end
