class CreateConnectSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :connect_sessions do |t|
      t.belongs_to :customer
      t.datetime :expires_at
      t.string :connect_url

      t.timestamps
    end
  end
end
