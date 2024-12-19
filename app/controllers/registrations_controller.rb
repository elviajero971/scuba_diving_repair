class RegistrationsController < Devise::RegistrationsController

  # add email after sign up

  def create
    super do |resource|
      if resource.persisted?
        resource.update(email: params[:user][:email])

        # send email to user
        UserMailer.with(user: resource).welcome_email.deliver_now
      end
    end
  end

  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end
end