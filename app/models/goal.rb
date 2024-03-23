class Goal < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category, optional: true
  #5文字以上の連続した文字列を制限
  NGWORD_REGEX = /(.)\1{4,}/.freeze
  #バリデーション
  with_options format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' } do
    validates :title, presence: true, obscenity: { sanitize: true }, length: { maximum: 20 }
    validates :reward, presence: true, obscenity: { sanitize: true }, length: { maximum: 30 }
  end
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true

  # action textの使用
  has_rich_text :content

  enum status: { not_started: 0, in_progress: 1, completed: 2}

  def cheered_by?(user)
   cheers.exists?(user_id: user.id)
  end
 # postへのいいね通知機能
 def create_notification_cheer_goal!(current_user)
   # 同じユーザーが同じ投稿に既にいいねしていないかを確認
   existing_notification = Notification.find_by(goal_id: self.id, visitor_id: current_user.id, action: "cheer_goal")

   # すでにいいねされていない場合のみ通知レコードを作成
   if existing_notification.nil? && current_user != self.user
     notification = Notification.new(
       goal_id: self.id,
       visitor_id: current_user.id,
       visited_id: self.user.id,
       action: "cheer_goal"
     )

     if notification.valid?
       notification.save
     end
   end
 end
    # コメントが投稿された際に通知を作成するメソッド
  def create_notification_comment!(current_user, comment_id)
   # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
   other_commenters_ids = Comment.select(:user_id).where(goal_id: id).where.not(user_id: current_user.id).distinct.pluck(:user_id)
   # 各コメントユーザーに対して通知を作成
   other_commenters_ids.each do |commenter_id|
     save_notification_comment!(current_user, comment_id, commenter_id)
   end
   # まだ誰もコメントしていない場合は、投稿者に通知を送る
   save_notification_comment!(current_user, comment_id, user_id) if other_commenters_ids.blank?
  end

 # 通知を保存するメソッド
 def save_notification_comment!(current_user, comment_id, visited_id)
   notification = current_user.active_notifications.build(
     goal_id: id,
     comment_id: comment_id,
     visited_id: visited_id,
     action: 'comment'
   )

   # 自分の投稿に対するコメントの場合は、通知済みとする
   notification.is_checked = true if notification.visitor_id == notification.visited_id

   # 通知を保存（バリデーションが成功する場合のみ）
   notification.save if notification.valid?
 end
end
