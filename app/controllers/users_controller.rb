class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.updateattributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    flash[:success] = "#{@user.name}を削除しました。"
    redirect_to root_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    # beforeフィルター
    
    # paramsハッシュからユーザーを取得
    def set_user
      @user = User.find(params[:id])
    end
    
    # ログイン済みのユーザーか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインして下さい。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user(@user)
    end
end
