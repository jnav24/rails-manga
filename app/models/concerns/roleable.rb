module Roleable
  extend ActiveSupport::Concern

  included do
    has_many :model_has_roles, as: :model, dependent: :destroy
    has_many :roles, through: :model_has_roles, source: :role

    scope :with_role, ->(role_name) {
      joins(:roles).where(roles: { name: role_name })
    }
  end

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end

  def revoke_role(role_name)
    role = Role.find_by(name: role_name)
    roles.destroy(role) if role
  end

  def grant_role(role_name)
    role = Role.find_by(name: role_name)
    roles << role if role && !has_role?(role_name)
  end
end
