class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    #  user.update_attribute(:email, auth[:info][:email])
      log_in user # 一時的セッション
      flash[:success] = "ログインしました。"
      redirect_back_or user
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user # 一時的セッション
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "ログインしました。"
        redirect_back_or user
      else
        flash.now[:danger] = "認証に失敗しました。"
        render :new
      end
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
end
