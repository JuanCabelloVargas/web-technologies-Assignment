class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  helper_method :current_user

  private

  def ensure_authenticated!
    return if current_user.present?
    redirect_to new_user_session_path, alert: "You must sign in to continue."
  end
end
