class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_posts
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  #バリデーション
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
