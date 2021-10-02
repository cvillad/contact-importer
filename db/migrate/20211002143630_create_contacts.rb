class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :date_of_birth
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :franchise
      t.string :email
      t.text :error_details, array: true, default: []
      t.belongs_to :contact_file, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
