class ContactFilesController < ApplicationController
  before_action :set_contact_file, only: :destroy

  def index
    @contact_files = current_user.contact_files.order(created_at: :desc)
    @contact_file = ContactFile.new
  end

  def create
    if contact_file_params[:file].present?
      @contact_file = current_user.contact_files.build(contact_file_params)
      result = ContactFiles::Create.call(@contact_file)
      if result.success?
        redirect_to new_contact_file_import_path(@contact_file), notice: 'File uploaded successfully!'
      else
        redirect_to contact_files_path, alert: result.error
      end
    else
      redirect_to contact_files_path, alert: 'File needed!'
    end
  end

  def destroy
    @contact_file.destroy
    redirect_to contact_files_path, alert: 'File deleted successfully!'
  end

  private
  def contact_file_params
    params.require(:contact_file).permit(:file)
  end

  def set_contact_file
    @contact_file = current_user.contact_files.find(params[:id])
  end
end
