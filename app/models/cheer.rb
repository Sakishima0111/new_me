class Cheer < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :goal

end
