class Cheer < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :goal

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
end
