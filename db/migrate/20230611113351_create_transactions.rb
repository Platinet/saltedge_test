class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :account
      t.string :remote_id
      t.boolean :duplicated, default: false
      t.string :mode
      t.string :status
      t.date :made_on
      t.decimal :amount, precision: 15, scale: 5
      t.string :currency_code
      t.string :description
      t.string :category
      t.jsonb :extra

      t.timestamps
    end
  end
end
