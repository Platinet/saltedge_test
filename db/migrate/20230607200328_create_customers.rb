class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.belongs_to :user

      t.string :remote_id
      t.string :identifier
      t.string :secret
      t.datetime :blocked_at

      t.timestamps
    end
  end
end
