class ContactFileHandler < ApplicationService
  require 'csv'

  attr_accessor :contact_file

  def initialize(contact_file)
    @contact_file = contact_file
  end

  def call
    file = contact_file.attachment_changes['file'].attachable
    contact_file.headers = ['empty']
    return OpenStruct.new(success?: false, error: contact_file.errors[:file].first) unless contact_file.valid?
    csv = CSV.open(file.path, headers: true)
    contact_file.headers = csv.read.headers
    contact_file.save!
    OpenStruct.new(success?: true, payload: contact_file)
  rescue ActiveRecord::RecordInvalid => e
    OpenStruct.new(success?: false, error: e.message.split(': ').last)
  end
end
