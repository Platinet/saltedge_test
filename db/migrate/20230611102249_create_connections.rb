class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.belongs_to :customer
      t.string :remote_id
      t.jsonb :response
      t.string :country_code
      t.datetime :last_success_at
      t.datetime :next_refresh_possible_at
      t.string :provider_id
      t.string :provider_code
      t.string :provider_name
      t.string :status
      t.boolean :removed, default: false

      t.timestamps
    end
  end
end
