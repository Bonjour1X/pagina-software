# frozen_string_literal: true

# Main application controller
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def visitor_mode?
    !user_signed_in?
  end
  helper_method :visitor_mode?
end
