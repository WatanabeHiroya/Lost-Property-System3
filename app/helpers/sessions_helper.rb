module SessionsHelper
  
  # ログイン
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 永続的セッションを記憶(Userモデル参照)
  def remember(user)
    user.remember # ハッシュ化したトークンをデータベースに記憶
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 永続的セッションを破棄
  def forget(user)
    user.forget # Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # ログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 一時的セッションにいるユーザーを返す
  # それ以外の場合はcookiesに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # ログイン確認
  def logged_in?
    !current_user.nil?
  end
  
end
