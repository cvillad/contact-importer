class ContactFilesController < ApplicationController
  def index
    @contact_files = current_user.contact_files
    @contact_file = current_user.contact_files.build
  end

  def create
    byebug
    @contact_file = current_user.contact_files.build(contact_file_params)
    if @contact_file.save
      redirect_to contact_files_path, notice: 'File uploaded successfully!'
    else
      redirect_to contact_files_path, alert: 'There were a problem uploaded you file!'
    end
  end

  def destroy
  end

  private
  def contact_file_params
    params.require(:contact_file).permit(:file)
  end
end
