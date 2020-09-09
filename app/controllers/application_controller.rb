class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # paramsハッシュからユーザーを取得
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_user2
    @user = User.find(params[:user_id])
  end
  
  # ログイン済みのユーザーか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインして下さい。"
      redirect_to login_url
    end
  end
  
  # すでにログインしているか確認
  def before_new
    if logged_in?
      flash[:info] = "すでにログインしています。"
      redirect_to @current_user
    end
  end
  
  # アクセスしたユーザーが現在ログインしているユーザーか確認
  def correct_user
    @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) # @user == current_user
  end
  
  # 管理権限者、現在ログインしているユーザーを許可します。
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to(root_url)
    end  
  end
  
  # システム管理権限所有者かどうか判定
  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
  def set_plan
   # @plan = Plan.find(params[:user_id])
    @plan = Plan.find(params[:id])
  end
end
