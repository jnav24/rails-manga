class Role < ApplicationRecord
  include Permissionable

  has_many :role_has_permission, dependent: :destroy
  has_many :permissions, through: :role_has_permission
end
