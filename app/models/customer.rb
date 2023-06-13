class Customer < ApplicationRecord
  belongs_to :user

  has_many :connect_sessions
  has_many :connections
end