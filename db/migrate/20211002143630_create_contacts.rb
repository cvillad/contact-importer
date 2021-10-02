class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.date :date_of_birth, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.integer :credit_card, null: false
      t.string :franchise, null: false
      t.string :email, null: false
      t.text :error_details, array: true, default: []
      t.belongs_to :contact_file, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
