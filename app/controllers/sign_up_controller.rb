class SignUpController < ApplicationController
  include Devise::Controllers::Helpers

  before_filter :require_no_authentication, :only => [ :new, :create ]

  # GET /resource/sign_up
  def new
    Devise::FLASH_MESSAGES.each do |message|
      set_now_flash_message :failure, message if params.try(:[], message) == "true"
    end
    build_resource
    render :new
  end

  # POST /resource/sign_up
  def create
    attributes = params[resource_name]
    if resource_class.create(attributes)
      set_flash_message :success, :signed_up
      sign_in_and_redirect(resource_name)
    else
      set_now_flash_message :failure, warden.message || :invalid
      build_resource
      render :new
    end
  end

end
