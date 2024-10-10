module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user! # Ensure only authenticated users access the backoffice
  end
end
