require "test_helper"

class PermissionTest < ActiveSupport::TestCase
  test "should save permission" do
    permission = Permission.new(name: "test")
    assert permission.save
  end

  test "should grant and revoke role" do
    permission = Permission.create(name: "test")
    role = Role.create(name: "test")

    role.grant_permission(permission.name)
    assert role.has_permission?(permission.name)

    role_role_has_permission = RoleHasPermission.where(role_id: role.id, permission_id: permission.id)
    assert_not_empty role_role_has_permission

    role.revoke_permission(permission.name)
    assert_not role.has_permission?(permission.name)
  end
end
