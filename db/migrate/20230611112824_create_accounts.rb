class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :connection
      t.string :remote_id
      t.string :name
      t.string :nature
      t.decimal :balance, precision: 15, scale: 5
      t.string :currency_code
      t.jsonb :extra

      t.timestamps
    end
  end
end
