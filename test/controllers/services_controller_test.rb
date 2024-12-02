require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data
    @user = User.create!(email: "jojo@email.com", password: "Password1!")
    @brand = Brand.create!(name: "Test Brand")
    @gear = Gear.create!(name: "Test Gear", brand: @brand, gear_type: :regulator)
    @service = Service.create!(user: @user, gear: @gear, service_type: :basic, status: :waiting_on_delivery, payment_status: :paid)
  end

  # Test index action when not signed in
  test "should redirect to sign-in for index when not signed in" do
    get services_path
    assert_redirected_to new_user_session_path
  end

  # Test index action when signed in
  test "should get index when signed in" do
    sign_in @user
    get services_path
    assert_response :success
  end

  # Test new action when not signed in
  test "should redirect to sign-in for new when not signed in" do
    get new_service_path
    assert_redirected_to new_user_session_path
  end

  # Test new action when signed in
  test "should get new when signed in" do
    sign_in @user
    get new_service_path
    assert_response :success
  end

  private

  # Helper method for signing in users
  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: "Password1!" } }
  end
end
