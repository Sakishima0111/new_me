class Goal < ApplicationRecord

  # action textの使用
  has_rich_text :content
end
