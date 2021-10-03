module ContactFiles
  class ImportsController < ApplicationController
    before_action :set_contact_file

    def new; end

    def create
      res = ContactFiles::Import.call(@contact_file, import_params)
      if res.success?
        redirect_to contacts_path, notice: 'File processed!'
      else
        redirect_to contacts_path, notice: res.error
      end
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
