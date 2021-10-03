class CsvImportJob < ApplicationJob
  def perform(args)
    contact_file = ContactFile.find(args[:contact_file_id])
    result = ContactFiles::Import.call(contact_file, args[:matched_headers])
    if result.success?
      succeeded_contacts_count, failed_contacts_count = result.succeeded.count, result.failed.count
      if succeeded_contacts_count.positive?
        contact_file.finished!
      elsif failed_contacts_count.positive?
        contact_file.failed!
      else
        contact_file.finished!
      end
    else
      contact_file.failed!
      puts "Error on sidekiq job: #{result.error}"
    end
  end
end
