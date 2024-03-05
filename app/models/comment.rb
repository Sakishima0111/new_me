class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :goal

  validates :body, presence: true
  

end
