class User < ApplicationRecord
  has_secure_password

  include Roleable
  include Permissionable

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
