class Goal < ApplicationRecord
  belongs_to :user
  # action textの使用
  has_rich_text :content
  
  enum status: { not_started: 0, in_progress: 1, completed: 2, closed: 3 }
end
