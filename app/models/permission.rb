class Permission < ApplicationRecord
  include Roleable

  has_many :role_has_permission, dependent: :destroy
  has_many :roles, through: :role_has_permission
end
