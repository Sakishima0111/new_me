class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
end
