class User < ApplicationRecord
  has_many :plans, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }, unless: :uid? # 追加
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true, unless: :uid? # 追加
  has_secure_password validations: false # 追加
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true, unless: :uid? # 追加
  
  
  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ログイン情報を破棄
  def forget
    return false if remember_digest.nil? # ダイジェストが存在しない場合はfalseを返して終了
    update_attribute(:remember_digest, nil)
  end
  
  
  #auth hashからユーザ情報を取得
  #データベースにユーザが存在するならユーザ取得して情報更新する；存在しないなら新しいユーザを作成する
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]
    #必要に応じて情報追加してください
  
    #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.username = name
      user.image_path = image
    end
  end
 
end
