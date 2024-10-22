# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options) # Autenticación de usuario
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash.now[:alert] = "Invalid email or password."
      self.resource = User.new # Inicializa el recurso
      resource.errors.add(:base, flash.now[:alert]) # Agrega el mensaje de error
      render :new and return # Asegúrate de detener la ejecución aquí
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # Protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
