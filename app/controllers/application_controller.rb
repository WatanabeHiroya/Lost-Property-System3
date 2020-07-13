class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # システム管理権限所有者かどうか判定
  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end
