class Goal < ApplicationRecord
  has_many :cheers, dependent: :destroy
  belongs_to :user
  # action textの使用
  has_rich_text :content
  
  enum status: { not_started: 0, in_progress: 1, completed: 2, closed: 3 }
   
  def cheered_by?(user)
   cheers.exists?(user_id: user.id)
  end
end
