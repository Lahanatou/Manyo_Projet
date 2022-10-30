class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required
    private
    def login_required
      if current_user==nil
      redirect_to new_session_path
      end
    end
end
