class Goal < ApplicationRecord
  belongs_to :user
  # action textの使用
  has_rich_text :content
end
