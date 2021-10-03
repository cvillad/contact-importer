class AddHeadersToContactFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_files, :headers, :text, array: true
  end
end
