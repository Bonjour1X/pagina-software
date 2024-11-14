# frozen_string_literal: true

# Main Render Controller
class RenderController < ApplicationController
  helper :all # Incluye todos los helpers, o específicamente Devise
  helper_method :user_signed_in?, :current_user
  def index; end

  def ajustes
    render 'ajustes'
  end

  def perfil
    @user = current_user 
    render 'perfil'
  end
end
