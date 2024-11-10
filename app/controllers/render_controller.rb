# frozen_string_literal: true

# Main Render Controller
class RenderController < ApplicationController
  helper :all # Incluye todos los helpers, o específicamente Devise
  helper_method :user_signed_in?, :current_user
  def index
    @courses = Course.all # Esto asegura que @courses esté definido y contenga los cursos disponibles
  end
  
  def ajustes
    render 'ajustes'
  end

  def perfil
    render 'perfil'
  end
end
