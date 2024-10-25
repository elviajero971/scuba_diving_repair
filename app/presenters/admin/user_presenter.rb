# ./presenters/admin/UserPresenter.rb
module Admin
  class UserPresenter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    # Return user's email
    def email
      user.email
    end

    # Return all gears associated with the user
    # Return all gears associated with the user with additional information
    def gears
      user.user_gears.map do |user_gear|
        OpenStruct.new(
          name: user_gear.gear.name,
          gear_type: user_gear.gear.gear_type,
          last_service_date: user_gear.last_service_date
        )
      end
    end

    # Return previous payments associated with the user
    def payments
      user.payments
    end

    # Return previous services associated with the user
    def services
      user.services
    end
  end
end
