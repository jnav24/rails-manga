require "test_helper"

class ModelHasPermissionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @permission = permissions(:one)
  end

  test "should be valid with all required attributes" do
    model_permission = ModelHasPermission.new(
      permission: @permission,
      model: @user
    )
    assert model_permission.valid?
  end

  test "should require a permission" do
    model_permission = ModelHasPermission.new(permission: nil, model: @user)
    assert_not model_permission.valid?
    assert_includes model_permission.errors[:permission], "must exist"
  end

  test "should require a model" do
    model_permission = ModelHasPermission.new(permission: @permission, model: nil)
    assert_not model_permission.valid?
    assert_includes model_permission.errors[:model], "must exist"
  end

  test "should not allow duplicate permission for same model" do
    user = User.create!(email_address: "test@test.com", password: "password")
    permission = Permission.create!(name: "test")
    ModelHasPermission.create!(permission:, model: user)
    duplicate = ModelHasPermission.new(permission:, model: user)
    assert_raises(ActiveRecord::RecordNotUnique) do
      duplicate.save(validate: false)
    end
  end

  test "should allow same permission for different models" do
    user = User.create!(email_address: "test@test.com", password: "password")
    user2 = User.create!(email_address: "test2@test.com", password: "password")
    permission = Permission.create!(name: "test")

    ModelHasPermission.create!(permission:, model: user)
    model_permission = ModelHasPermission.new(permission:, model: user2)

    assert model_permission.valid?
  end
end
