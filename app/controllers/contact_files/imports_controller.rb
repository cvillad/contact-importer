module ContactFiles
  class ImportsController < ApplicationController
    before_action :set_contact_file

    def new; end

    def create
      CsvImportJob.perform_later(contact_file_id: @contact_file.id, matched_headers: import_params)
      @contact_file.processing!
      redirect_to contact_files_path, notice: 'Your file is being processed...'
    end

    private
    def set_contact_file
      @contact_file = current_user.contact_files.find(params[:contact_file_id])
    end

    def import_params
      params.require(:import).permit(:name, :email, :date_of_birth, :phone, :address, :credit_card)
    end
  end
end
