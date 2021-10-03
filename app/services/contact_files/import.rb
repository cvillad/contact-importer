module ContactFiles
  class Import < ApplicationService
    require 'csv'

    attr_accessor :contact_file, :matched_headers

    def initialize(contact_file, matched_headers)
      @contact_file = contact_file
      @matched_headers = matched_headers
    end

    def call
      valid_contacts, invalid_contacts = [], []
      table = CSV.parse(contact_file.file.download, headers:  true)
      table.each do |row|
        contact = contact_file.contacts.build(
          email: row[matched_headers[:email]],
          name: row[matched_headers[:name]],
          date_of_birth: row[matched_headers[:date_of_birth]],
          phone: row[matched_headers[:phone]],
          address: row[matched_headers[:address]],
          credit_card: row[matched_headers[:credit_card]]
        )
        contact.valid? ? valid_contacts << contact : invalid_contacts << contact
      end
      result = create_succeeded_contacts(valid_contacts)
      create_failed_contacts(invalid_contacts)
      OpenStruct.new(success?: true, succeeded: valid_contacts, failed: invalid_contacts)
    rescue => e
      OpenStruct.new(success?: false, error: e.message)
    end

    private
    def create_failed_contacts(contacts)
      contacts.each do |contact|
        contact.error_details = contact.errors.full_messages
        contact.status = :failed
      end
      Contact.import contacts, validate: false
    end

    def create_succeeded_contacts(contacts)
      contacts.each do |contact|
        contact.run_callbacks(:save) { false }
      end
      Contact.import contacts, validate: false
    end
  end
end
