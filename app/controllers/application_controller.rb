class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to dashboard_path, :alert => "No estas autorizado para ejecutar esa accion."
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

end
