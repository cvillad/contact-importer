module CsvHandler
  def self.load(file)
    ActiveStorage::Blob.create_and_upload!(
        io: File.open(file, 'rb'),
        filename: 'contacts.csv',
        content_type: 'text/csv'
    ).signed_id
  end
end
