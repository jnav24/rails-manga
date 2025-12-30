require "test_helper"

class ModelHasRoleTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @role = roles(:one)
  end

  test "should be valid with all required attributes" do
    mode_role = ModelHasRole.new(
      role: @role,
      model: @user
    )
    assert mode_role.valid?
  end

  test "should require a role" do
    model_role = ModelHasRole.new(role: nil, model: @user)
    assert_not model_role.valid?
    assert_includes model_role.errors[:role], "must exist"
  end

  test "should require a model" do
    model_role = ModelHasRole.new(role: @role, model: nil)
    assert_not model_role.valid?
    assert_includes model_role.errors[:model], "must exist"
  end

  test "should not allow duplicate role for same model" do
    user = User.create!(email_address: "test@test.com", password: "password")
    role = Role.create!(name: "test")
    ModelHasRole.create!(role:, model: user)
    duplicate = ModelHasRole.new(role:, model: user)
    assert_raises(ActiveRecord::RecordNotUnique) do
      duplicate.save(validate: false)
    end
  end

  test "should allow same role for different models" do
    user = User.create!(email_address: "test@test.com", password: "password")
    user2 = User.create!(email_address: "test2@test.com", password: "password")
    role = Role.create!(name: "test")

    ModelHasRole.create!(role:, model: user)
    model_role = ModelHasRole.new(role:, model: user2)

    assert model_role.valid?
  end
end
