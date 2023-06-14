class ConnectSession < ApplicationRecord
  belongs_to :customer

  scope :active, -> { where("expires_at > ?", Time.current) }
end