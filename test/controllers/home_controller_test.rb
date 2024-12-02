require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data
    @user = User.create!(email: "jojo@email.com", password: "Password1!")
    @brand = Brand.create!(name: "Test Brand")
    @gear = Gear.create!(name: "Test Gear", brand: @brand, gear_type: :regulator)
    @service = Service.create!(user: @user, gear: @gear, service_type: :basic, status: :waiting_on_delivery, payment_status: :paid)
  end

  test "should get home index when connected user try to get root_path" do
    sign_in @user
    get root_path
    assert_redirected_to services_path
  end

  test "should redirect to sign-in for root_path when not signed in" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  private

  # Helper method for signing in users
  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: "Password1!" } }
  end
end
