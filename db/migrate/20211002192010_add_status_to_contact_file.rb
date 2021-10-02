class AddStatusToContactFile < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_files, :status, :integer, default: 0
  end
end
