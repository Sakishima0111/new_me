class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :reports, as: :content, dependent: :destroy
  belongs_to :user
  belongs_to :goal

  validates :body, presence: true, obscenity: { sanitize: true }
end
