class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  def current_user
    User.find(18)  # reemplaza 18 con un ID válido de tu base de datos
  end
  helper_method :current_user
end
