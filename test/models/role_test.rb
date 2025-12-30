require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "should save role" do
    role = Role.new(name: "admin")
    assert role.save
  end

  test "should attach and revoke permission" do
    role = Role.new(name: "admin")
    permission = Permission.create(name: 'test')
    assert role.save

    role.grant_permission(permission.name)
    assert role.has_permission?(permission.name)

    role.revoke_permission(permission.name)
    assert_not role.has_permission?(permission.name)
  end
end
