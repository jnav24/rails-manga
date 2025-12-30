require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "should grant and revoke permission" do
    user = User.create!(email_address: "test@test.com", password: "password")
    permission = Permission.create(name: "test")

    user.grant_permission(permission.name)
    user.reload
    assert user.has_permission?(permission.name)

    model_has_permission = ModelHasPermission.where(model_id: user.id, permission_id: permission.id)
    assert_not_empty model_has_permission

    assert_equal 1, user.permissions.size

    user.revoke_permission(permission.name)
    assert_not user.has_permission?(permission.name)

    assert_equal 0, user.permissions.size
  end

  test "should grant and revoke role" do
    user = User.create!(email_address: "test@test.com", password: "password")
    role = Role.create!(name: "test")

    user.grant_role(role.name)
    user.reload
    assert user.has_role?(role.name)

    model_has_role = ModelHasRole.where(model_id: user.id, role_id: role.id)
    assert_not_empty model_has_role

    assert_equal 1, user.roles.size

    user.revoke_role(role.name)
    assert_not user.has_role?(role.name)

    assert_equal 0, user.roles.size
  end
end
