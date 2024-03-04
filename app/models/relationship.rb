class Relationship < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

end
