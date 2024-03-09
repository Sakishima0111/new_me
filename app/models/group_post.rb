class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :user

  has_rich_text :content
  validates :content, presence: true

end
