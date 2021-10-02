class CreateContactFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_files do |t|
      t.jsonb :columns
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
