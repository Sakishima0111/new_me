class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  has_one_attached :image

  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :follower
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :following
  has_many :goals, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy #相手からの通知
  has_many :reporter, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  has_many :group_posts
  #バリデーション
  validates :nickname, presence: true
  # validate :guest_user_cannot_update, on: :update
  def active_for_authentication?
    super && (is_active == true)
  end
  def status_text
    if is_active == true
      "有効"
    else
      "退会済み"
    end
  end
  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def following?(other_user)
    self.followings.exists?(other_user.id)
  end
  # フォロー通知を作成するメソッド
  def create_notification_follow!(current_user)
    # すでにフォロー通知が存在するか検索
    existing_notification = Notification.find_by(visitor_id: current_user.id, visited_id: self.id, action: 'follow')
    # フォロー通知が存在しない場合のみ、通知レコードを作成
    if existing_notification.blank?
      notification = current_user.active_notifications.build(
        visited_id: self.id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  #画像の有無による表示設定の定義。'image.get_profile_image'のように使う
  def get_profile_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpeg', content_type: 'image/jpeg')
    end
      image
  end
  # ゲストログイン用記述
  def self.guest
    #探してなければ作成するメソッド
    find_or_create_by!(email: 'guest@example.com') do |user|
      #パスワードを自動作成
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
      user.introduction = "現在ゲストユーザーとしてログインしています。ゲストユーザーは一部の機能を制限されています。"
    end
  end

  #ライン認証
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

end
