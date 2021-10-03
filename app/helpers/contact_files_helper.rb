module ContactFilesHelper
  def contact_headers
    %i[name email date_of_birth phone address credit_card]
  end

  def format_date(date)
    date&.strftime('%Y %B %d')
  end
end
