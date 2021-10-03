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
      CSV.foreach @contact_file.file_path, headers: true do |row|
        contact_params = row.to_h.transform_keys { |key| matched_headers.to_h.key(key)  }
        contact = @contact_file.contacts.build(contact_params)
        contact.valid? ? valid_contacts << contact : invalid_contacts << contact
      end
      result = create_succeeded_contacts(valid_contacts)
      create_failed_contacts(invalid_contacts)
      OpenStruct.new(success?: true, imported: valid_contacts, errors: invalid_contacts)
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
