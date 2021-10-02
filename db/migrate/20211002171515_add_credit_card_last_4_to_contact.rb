class AddCreditCardLast4ToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :credit_card_last_4, :string
  end
end
