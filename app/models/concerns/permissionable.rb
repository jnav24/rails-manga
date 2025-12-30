module Permissionable
  extend ActiveSupport::Concern

  included do
    has_many :model_has_permissions, as: :model, dependent: :destroy
    has_many :permissions, through: :model_has_permissions, source: :permission

    scope :with_permission, ->(permission_name) {
      joins(:permissions).where(permissions: { name: permission_name })
    }
  end

  def has_permission?(permission_name)
    permissions.exists?(name: permission_name)
  end

  def revoke_permission(permission_name)
    permission = Permission.find_by(name: permission_name)
    permissions.destroy(permission) if permission
  end

  def grant_permission(permission_name)
    permission = Permission.find_by(name: permission_name)

    permissions << permission if permission && !has_permission?(permission_name)
  end
end